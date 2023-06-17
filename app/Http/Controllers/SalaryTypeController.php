<?php

namespace App\Http\Controllers;

use App\DataTables\SalaryTypeDataTable;
use App\Models\SalaryType;
use Illuminate\Http\Request;

class SalaryTypeController extends Controller
{
    public function index(SalaryTypeDataTable $salaryTypeDataTable)
    {
        $data['page'] = 'index';
        $data['title'] = 'Salary Types';
        return $salaryTypeDataTable->render('home', $data);
    }

    public function create() //view('salaryType.create')
    {
        $data['page'] = 'salaryType.create';
        $data['title'] = 'New Salary Type';
        return view('home', $data);
    }

    public function edit(string $id) //view('salaryType.edit')
    {
        $data['salaryType'] = SalaryType::findorfail($id);
        // dd($data); 
        $data['page'] = 'salaryType.edit';
        $data['title'] = 'Edit Salary Type';
        return view('home', $data);
    }

    public function store(Request $request) { return $this->upstore($request, new SalaryType()); }

    public function update(Request $request, SalaryType $salaryType) { return $this->upstore($request, $salaryType); }

    public function upstore($request, $salaryType) {
        $input = $request->validate(['title' => 'required', 'status' => 'nullable']);
        $salaryType->title = $input['title'];
        if(request()->ajax()) $salaryType->status = 1;
        else $salaryType->status = ($input['status'] == 'on') ? 1 : 0;
        $salaryType->entry = entry();
        $salaryType->save();
        $msg = isUpdate() ? 'Salary Type Updated Successfully' : 'Salary Type Created Successfully'; 
        if(request()->ajax()) return response()->json(['message' => $msg], 200);
        return to_route('salary-type.index')->with(['message' => $msg, 'alert-type' => 'success']);
    }
}