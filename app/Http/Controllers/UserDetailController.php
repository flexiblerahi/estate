<?php

namespace App\Http\Controllers;

use App\DataTables\UserDetailDataTable;
use App\Models\Commission;
use App\Models\User;
use App\Models\UserDetail;
use Illuminate\Http\Request;

class UserDetailController extends Controller
{
    private $user;
    public function __construct() {
        $this->user = request()->get('user');
        if(in_array($this->user, ['accountant', 'shareholder'])) {
            $this->middleware('permission:'.$this->user.'-list|'.$this->user.'-view', ['only' => ['index', 'show']]);
        } else {
            $this->middleware('permission:'.$this->user.'-list|'.$this->user.'-view|new-'.$this->user.'|'.$this->user.'-edit', ['only' => ['index', 'show', 'edit', 'updatestatus', 'update', 'store', 'create']]);
            $this->middleware('permission:'.$this->user.'-edit', ['only' => ['edit', 'update', 'updatestatus']]);
            $this->middleware('permission:new-'.$this->user, ['only' => ['store', 'create']]);
        }
        $this->middleware('permission:'.$this->user.'-view', ['only' => ['show']]);
        if(!key_exists($this->user, UserDetail::USER)) abort(404, 'Unknown User');
    }

    public function index(UserDetailDataTable $userDetailDataTable) //view('index') view('report.modalform')view('modules.modal')
    {
        $data['page'] = 'index';
        $data['title'] = ucfirst($this->user);
        if(auth()->user()->can($this->user.'-view')) {
            $data['modal'] = 'modules.modal';
            $data['modal_title'] = ucfirst($this->user).' Detail';
            $data['modal_type'] = $this->user;
        }
        return $userDetailDataTable->render('home', $data);
    }

    public function show($id) //view('accountant.show') //view('customer.show') //view('shareholder.show') //view('agent.show')
    {
        if(request()->ajax()) {
            $data[$this->user] = UserDetail::find($id);
            return view($this->user.'.show', $data)->render();
        } return abort(404);
    }

    public function create() //view('agent.create')
    {
        $data['page'] = $this->user.'.create';
        $data['title'] = 'New '.ucfirst($this->user);
        return view('home', $data);
    }

    public function edit(string $id)//view('agent.edit') //view('customer.edit')
    {
        $data[$this->user] = UserDetail::findorfail($id);
        if($this->user == 'agent') {
            $agentId = $data['agentId'] = explode(',', $data['agent']->reference_id);
            $data['sh_agent'] = UserDetail::query()->where('id', $agentId[0])->select('id', 'role', 'name', 'phone', 'account_id')->first();
        }
        $data['page'] = $this->user.'.edit';
        $data['title'] = ucfirst($this->user).' Details Edit';
        return view('home', $data);
    }

    public function update(Request $request, $id)
    {
        $this->validation($request);
        return $this->upstore($request, $id);
    }

    public function store(Request $request)
    {
        $this->validation($request);
        return $this->upstore($request);
    }

    private function upstore($request, $id = null)
    {
        $userId = ($this->user == 'agent') ? $request->input('reference_id') : auth()->id();
        $refernceId = UserDetail::where('id', $userId)->first();
        if(!$refernceId) {
            if(request()->ajax()) return response()->json(['message' => 'Refrence Id Does Not Exist'], 404);
            return redirect()->back()->with(['message' => 'Refrence Id Does Not Exist', 'alert-type' => 'error']);
        }
        if(is_null($id)) {
            $user_detail = new UserDetail();
            $user_detail->role = UserDetail::USER[$this->user];
            $user_detail->image = uploadFile($request->image, ((int) (UserDetail::latest()->first()->id) + 1), '/profile/');
        }
        else {
            $user_detail = UserDetail::findorfail($id);
            $user_detail->image = uploadFile($request->image, $user_detail->id, '/profile/', $user_detail->image);
        }
        $user_detail->refer_id = $userId;
        $user_detail->reference_id = $userId.','.$refernceId->reference_id;
        $user_detail->name = $request->input('name');
        $user_detail->phone = $request->input('phone');
        $user_detail->present_address = $request->input('present_address');
        $user_detail->permanent_address = $request->input('permanent_address');
        $user_detail->emergency_contact =  $request->input('emergency_contact');
        $user_detail->occupation = $request->input('occupation');
        $user_detail->parent_name = json_encode(['father' => $request->input('father'), 'mother' => $request->input('mother')]);
        $user_detail->account_id = UserDetail::TYPE[$this->user].$request->input('account_id');
        if(request()->ajax()) $user_detail->status = 1;
        else $user_detail->status = ($request->status == 'on') ? 1 : 0;
        $user_detail->save();
        if(request()->ajax()) return response()->json(['customer' => $user_detail, 'message' => ucfirst($this->user).' Created Successfully'], 200);
        $msg = (is_null($id)) ?  ucfirst($this->user).' Created Successfully' : ucfirst($this->user).' Updated Successfully';
        return redirect()->route('user-detail.index', ['user' => $this->user])->with(['message' => $msg, 'alert-type' => 'success']);
    }

    public function usersearch(Request $request)
    {  
        $input = $request->all();
        $data['users'] = array();
        if(is_null($input['query'])) return response()->json($data);
        $data['users'] = UserDetail::filterusers($input['query'], UserDetail::queryroles($input['type'])); // Illuminate\Database\Eloquent\Builder::filterusers 252 lines
        if(count($data['users']) == 1) {   
            if($input['type'] == 'agent') $data['view'] = view($this->user.'.referenceDetails', $data)->render();
            else { //['customer', 'saleCreate', 'saleEdit', 'withdraw'] == $input['type']
                $data['user'] = UserDetail::with('user')->find($data['users'][0]->id);
                if($input['type'] == 'withdraw') $data['view'] = view('withdraw.userInfo', $data)->render();
                else if($input['type'] == 'customer') $data['view'] = view('sale.customerInfo', $data)->render();
                else $data = $this->saleCommission($data);
            }
        }
        return response()->json($data);
    } 

    public function saleCommission($data)
    {
        $data['rank'] = countRank($data['user']->total_kata);
        $data['commissions'] = Commission::all(['id', 'type', 'total', 'rank'.$data['rank']." as rank"]);
        if($data['user']->role == 4) { // UserDetail::USER['agent'] ==  4
            $data['referencesIds'] = referenceIds($data['user']->reference_id);
            $users = UserDetail::query()->whereIn('id', $data['referencesIds'])->select('account_id', 'role', 'name', 'phone', 'total_kata', 'id')->get();
            $data['agents'] = $users->where('role', UserDetail::USER['agent'])->toArray();
            array_unshift($data['agents'], $data['user']->toArray());
            $data['shareholder'] = $users->where('role', UserDetail::USER['shareholder'])->first()->toArray();
        }
        $data['view']= view('sale.agentInfo', $data)->render();
        return $data;
    }

    public function updatestatus(Request $request)
    {
        $user_detail = UserDetail::findorfail($request->get('id'));
        $user_detail->status = $request->get('status');
        $user_detail->save();
        if(in_array($this->user, ['accountant', 'shareholder'])) User::status($user_detail->user_id, $user_detail->status);
        return response()->json(['message' => 'Status Update Successfully', 'alert-type' => 'success']);        
    }

    public function validation($request)
    {
        $validate['name'] = ['required','string','max:255'];
        $validate['account_id'] = ['required'];
        $validate['phone'] = ['required'];
        $validate['present_address'] = ['required'];
        $validate['permanent_address'] = ['required'];
        $validate['father'] = ['required','string','max:255'];
        $validate['mother'] = ['required','string','max:255'];
        if($this->user == 'agent') $validate['reference_id'] = ['required'];
        $request->validate($validate, ['reference_id' => 'Reference Agent or Shareholder must be required.']);
    }

    public static function updateAmount($commissions, $referencesIds, $amount, $payment) { // comming from deposit payment 
        $total_commission = 0;
        $user_details = UserDetail::query()->whereIn('account_id', $referencesIds)->select('income', 'account_id', 'id')->get();
        $transactions = array();
        foreach($user_details as $user) {
            $commission = $commissions[array_search($user->account_id, array_column($commissions, 'account_id'))];
            if(isUpdate()) {
                $prev_commissions = json_decode($payment->commission, 1);
                // dd($prev_commissions);
                $prev_commission = $prev_commissions[array_search($user->account_id, array_column($prev_commissions, 'account_id'))];
                $user->income =(double) $user->income - ($payment->amount * ($prev_commission['percentage']/100));
            }
            $total_commission = $total_commission + $commission['percentage'];
            $cash = $amount * ($commission['percentage']/100);
            $user->income =(double) $user->income + $cash;
            $transactions[] =  ['user_details_id' => $user->id, 'amount' => $cash, 'percentage' => $commission['percentage'], 'balance' => $user->income];
            $user->save();
        }

        $gm = UserDetail::find(1); // gm = general manager
        if(isUpdate()) {
            $prev_commission = $prev_commissions[array_search($gm->account_id, array_column($prev_commissions, 'account_id'))];
            $gm->income = (double) $gm->income - ($payment->amount * (($prev_commission['percentage'])/100));
        }
        $gm_percentage = 100-$total_commission;
        $gmcash = $amount * ($gm_percentage/100);
        $gm->income = (double) $gm->income + $gmcash;
        $gm->save();
        $transactions[] =  ['user_details_id' => $gm->id, 'amount' => $gmcash, 'percentage' => $gm_percentage, 'balance' => $gm->income];
        $commissions[] = ["hand" => "general_manager", "account_id" => $gm->account_id, "percentage" => $gm_percentage];
        return ['total_commission' => $total_commission, 'transactions' => $transactions, 'commissions' => $commissions];
    }
}