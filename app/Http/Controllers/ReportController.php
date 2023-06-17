<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use Illuminate\Http\Request;
use App\Models\Sale;
use App\Models\Transaction;
use App\Models\User;
use App\Models\UserDetail;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ReportController extends Controller
{
    public function __construct() {
        $this->middleware('permission:report-list|report-customers|report-agents|report-sale-total|report-sale-individual|report-deposit|report-withdraw|report-transaction', ['only' => ['all', 'customersReport', 'agentsReport', 'shareholdersReport', 'saleReport', 'depositReport', 'withdrawReport', 'transactionReport']]);
        $this->middleware('permission:report-customers', ['only' => ['customersReport']]);
        $this->middleware('permission:report-agents', ['only' => ['agentsReport']]);
        $this->middleware('permission:report-sale-total', ['only' => ['shareholdersReport']]);
        $this->middleware('permission:report-sale-individual', ['only' => ['saleReport']]);
        $this->middleware('permission:report-deposit', ['only' => ['depositReport']]);
        $this->middleware('permission:report-withdraw', ['only' => ['withdrawReport']]);
        $this->middleware('permission:report-transaction', ['only' => ['transactionReport']]);
    }

    public function index() //view('report.index')
    {
        $data['title'] = 'Reports';
        $data['page'] = 'report.index';
        return view('home', $data);
    }

    public function userInfo(Request $request)
    {
        $query = $request->get('query');
        $user_details_query = UserDetail::query()->where('status', 1);
        $data['users'] = $user_details_query->where('phone', 'like', $query. '%')->orWhere('account_id', 'like', $query. '%')->select('id', 'account_id', 'phone')->get();
        if(count($data['users']) == 1) {
            $user = $data['users']->first();
            $user = UserDetail::find($user->id);
            $data['user'] = $user;
            $data['roles'] = array_flip(UserDetail::USER);
            return view('report.userInfo', $data);
        }
        return response()->json($data);
    }

    public function all(Request $request)
    {
        return $this->{$request->input('type').'Report'}($request);
    }

    public function customersReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $data['shareholder'] = $user = UserDetail::where('id', $request->get('user_id'))->firstorfail();
        $role = $user->role_name;
        if(!in_array($role, ['shareholder', 'agent'])) return redirect()->back()->with(['message' => 'No Report for '.ucfirst(str_replace('-', ' ', $role)), 'alert-type' => 'warning']);
        $customers = Sale::select('customer_id', DB::raw('SUM(kata) as total_amount'))->groupBy('customer_id');
        $data['customers'] = $customers->where($role.'_id', $user->id)->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->with('customer')->get();
        $data['heading'] = "<h4>Customer's list of ". ucfirst($role). ': '. $user->name. '</h4>';
        $data['title'] = 'Customer List';
        $data['page'] = 'report.customer'; //view('report.customer')
        return view('report.view', $data);
    }

    public function validation($request)
    {
        $rules['from'] = 'required';
        $rules['to'] = 'required';
        $customMessages['from.required'] = 'From Date is required!';
        $customMessages['to.required'] = 'to Date Email is required!';
        if(!in_array($request->input('type'), ['shareholders', 'deposit'])) {
            $rules['user_id'] = 'required';
            $customMessages['user_id.required'] = 'Undefined User!';
        }
        $this->validate($request, $rules, $customMessages);
    }

    public function saleReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate = $data['endDate'] = $request->get('to');
        $data['user'] = $user = UserDetail::where('id', $request->get('user_id'))->firstorfail();
        if(!in_array($user->role_name, ['shareholder', 'agent'])) return redirect()->back()->with(['message' => 'No Report for '.ucfirst(str_replace('-', ' ', $user->role_name)), 'alert-type' => 'warning']);

        $role = $data['user']->role_name; 
        $data['sales'] = Sale::where($role.'_id', $data['user']->id)->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->with('customer')->get();
        
        $data['title'] = "Sale's List";
        $data['heading'] = "<h4>Sale's list of ". ucfirst($user->role_name). ': '. $user->name. '</h4>';
        $data['page'] = 'report.sale'; //view('report.sale')
        return view('report.view', $data);
    }

    public function agentsReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $data['shareholder']  = $user = UserDetail::where('id', $request->get('user_id'))->firstorfail();
        if(!in_array($user->role_name, ['shareholder', 'agent'])) return redirect()->back()->with(['message' => 'No Report for '.ucfirst(str_replace('-', ' ', $user->role_name)), 'alert-type' => 'warning']);
        $data['agents'] = UserDetail::with('sales')->where('reference_id', 'like', '%,'. $request->get('user_id'))
        ->orWhere('reference_id', 'like', '%,'.$request->get('user_id').',')
        ->orWhere('reference_id', 'like', '%,'.$request->get('user_id').',%')
        ->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->get();
        
        $data['title'] = "Agent's List";
        $data['heading'] = "<h4>Agent's information</h4>";
        $data['heading'] = "<h4>Agent's list of ". ucfirst($user->role_name). ': '. $user->name. '</h4>';
        $data['page'] = 'report.agent'; //view('report.agent')
        return view('report.view', $data);
    }

    public function agentsDetailsReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $data['shareholder']  = $user = UserDetail::where('id', $request->get('user_id'))->firstorfail();
        if($user->role_name != 'shareholder') return redirect()->back()->with(['message' => 'No Report for '.ucfirst(str_replace('-', ' ', $user->role_name)), 'alert-type' => 'warning']);
        
        $data['agents'] = $agents = UserDetail::query()->with(['sales', 'transactions' => function($q) use ($startDate, $endDate){
            $q->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')]);
        }, 'refer_account:account_id,id'])
        ->where('reference_id', 'like', '%,'. $request->get('user_id'))
        ->orWhere('reference_id', 'like', '%,'.$request->get('user_id').',')
        ->orWhere('reference_id', 'like', '%,'.$request->get('user_id').',%')
        ->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->get();
        $ids = $agents->pluck('id');
        $data['refer_users'] = UserDetail::whereIn('reference_id', function($query) use ($ids) {
                $query->select('reference_id')
                    ->from('user_details');
                foreach($ids as $id) {
                    $query->orWhere('reference_id', 'like', $id.',%')->orWhere('reference_id', 'like', '%,'.$id.',%');
                }
            })
            ->pluck('reference_id');
        $data['title'] = "Agent's List";
        $data['heading'] = "<h4>Agent's information</h4>";
        $data['heading'] = "<h4>Agent's list of ". ucfirst($user->role_name). ': '. $user->name. '</h4>';
        $data['page'] = 'report.agentdetails'; //view('report.agentdetails')
        return view('report.view', $data);
    }

    public function shareholdersReport(Request $request)
    {
        // $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $sales = Sale::select('shareholder_id', DB::raw('SUM(kata) as total_amount'))->groupBy('shareholder_id')->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')]);
        $data['shareholders'] = $sales->with('shareholder')->get();
        $data['title'] = "Total Sale Report";
        $data['heading'] = "<h4>Total Sale Report</h4>";
        $data['page'] = 'report.shareholder'; //view('report.shareholder')
        return view('report.view', $data);
    }

    public function depositReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $data['deposits'] = Payment::query()->with('sale')->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->get();

        $data['title'] = 'Deposit List';
        $data['heading'] = "<h4>Deposit Report </h4>";
        $data['page'] = 'report.deposit'; //view('report.deposit')
        return view('report.view', $data);
    }

    public function withdrawReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $user_id = $request->get('user_id');
        $data['user']= $user = UserDetail::find($user_id);
        $data['withdraws']= $withdraws = Transaction::query()->where(['user_details_id' => $user_id, 'type' => 0])->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->get();
        $data['title'] = 'Withdraw List';
        $data['heading'] = "<h4>Withdraw list of ". ucfirst($user->role_name). ': '. $user->name. '</h4>';
        // dd($data['withdraws']);
        $data['total'] = $withdraws->sum('amount');
        // dd($data['total']);
        $data['page'] = 'report.withdraw'; //view('report.withdraw')
        return view('report.view', $data);
    }

    public function transactionReport(Request $request)
    {
        $this->validation($request);
        $startDate = $data['startDate'] = $request->get('from'); 
        $endDate= $data['endDate'] = $request->get('to');
        $user_id = $request->get('user_id');
        $data['user'] = $user = UserDetail::find($user_id);
        $data['transactions'] = $transactions = Transaction::with('payment', 'payment.sale', 'payment.sale.shareholder', 'payment.sale.agent')->where('user_details_id', $user_id)->whereBetween('created_at', [$startDate, Carbon::parse($endDate. ' 24:00:00')])->get();
        // dd($transactions);
        $data['total_commission'] = $transactions->where('type', 1)->sum('amount');
        $data['total_withdraw'] = $transactions->where('type', 0)->sum('amount');
        // dd($data['total_withdraw']);
        $data['title'] = 'Transaction List';
        $data['heading'] = "<h4>Transaction list of ". ucfirst($user->role_name). ': '. $user->name. '</h4>';
        $data['page'] = 'report.transaction'; //view('report.transaction')
        $data['balance'] = 0;
        return view('report.view', $data);
    }
}
