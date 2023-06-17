<?php

namespace App\Http\Controllers;

use App\DataTables\EmployeeDataTable;
use App\Models\UserDetail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmployeeController extends Controller
{
    public function index(EmployeeDataTable $employeeDataTable)
    {
        $data['page'] = 'index';   
        $data['title'] = 'Employees';
        $data['modal'] = 'modules.modal';
        $data['modal_title'] = 'Employee Detail';
        $data['modal_type'] = 'employee';
        $data['modalbodyClass'] = 'p-0';
        $employeeDataTable->setModaltype($data['modal_type']);
        return $employeeDataTable->render('home', $data);
    }

    public function create() {// view('employee.create')
        $data['title'] = 'New Employee';
        $data['page'] = 'employee.create';
        return view('home', $data);
    }

    public function show(string $id) // view('employee.show')
    {
        if(request()->ajax()) {
            $data['employee'] = UserDetail::findorfail($id);
            return view('employee.show', $data)->render();
        } else abort(404);       
    }

    public function edit(string $id) { // view('employee.edit')
        $data['employee'] = UserDetail::findorfail($id);
        $data['title'] = 'Edit Employee Profile';
        $data['page'] = 'employee.edit';
        return view('home', $data);
    }

    public function store(Request $request) { return $this->upstore($request); }

    public function update(Request $request, string $id) { return $this->upstore($request, $id); }

    public function upstore($request, $id = null) {
        $input = $this->validation($request);
        if(is_null($id)) {
            $user_detail = new UserDetail();
            $user_detail->image = (key_exists('image', $input)) ? uploadFile($request->image, (int) $input['account_id'], "/profile/") : null;
            if(is_null($input['account_id'])) $input['account_id'] = 'Em'.autoIdGenerator('user_details', true, true);
            else {
                $input['account_id'] = 'Em'.$input['account_id'];
                $user_details = DB::table('user_details')->where('account_id', $input['account_id'])->get();
                if(count($user_details)>0) return redirect()->back()->with(['message' => 'This account number already exist.', 'alert-type' => 'error']);            }
            $user_detail->account_id = $input['account_id'];
        } else {
            $user_detail = UserDetail::findorfail($id);
            $user_detail->image = (key_exists('image', $input)) ? uploadFile($request->image, $user_detail->account_id, '/profile/', $user_detail->image) : null;
        }
        $user_detail->name = $input['name']; 
        $user_detail->phone = $input['phone']; 
        $user_detail->present_address = $input['present_address']; 
        $user_detail->permanent_address = $input['permanent_address']; 
        $user_detail->emergency_contact = $input['emergency_contact']; 
        $user_detail->occupation = $input['occupation']; 
        $user_detail->parent_name = json_encode(['father' => $input['father'], 'mother' => $input['mother']]);
        $user_detail->status = ($input['status'] == 'on') ? 1 : 0;
        $user_detail->role = 7; //employee role id 7 from roles table
        $user_detail->save();
        $msg = is_null($id) ? 'Employee Created Successfully' : 'Employee Update Successfully';
        return redirect()->route('employee.index')->with(['message' => $msg, 'alert-type' => 'success']);
    }

    public function validation($request)
    {
        $validate['name'] = ['required','string','max:255'];
        $validate['account_id'] = ['nullable'];
        $validate['phone'] = ['required'];
        $validate['status'] = ['nullable'];
        $validate['emergency_contact'] = ['nullable'];
        $validate['image'] = ['nullable'];
        $validate['occupation'] = ['nullable'];
        $validate['present_address'] = ['required'];
        $validate['permanent_address'] = ['required'];
        $validate['father'] = ['required','string','max:255'];
        $validate['mother'] = ['required','string','max:255'];
        return $request->validate($validate);
    }
}