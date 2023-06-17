<?php

namespace App\Http\Controllers;

use App\DataTables\ExpenseItemDataTable;
use App\Models\BackupExpenseItem;
use App\Models\ExpenseItem;
use Illuminate\Http\Request;

class ExpenseItemController extends Controller
{
    public function index(ExpenseItemDataTable $expenseItemDataTable) //view('index') //view('modules.modal')
    {
        $data = [ 'page' => 'index', 'title' => 'Expense Types' ];
        // if(auth()->user()->can('investment-view')) {
            $data['modal'] = 'modules.modal';
            $data['modal_type'] = 'expenseItem';
            $data['modal_title'] = 'Expese Type Details';
            $data['modalbodyClass'] = 'p-0';
            $expenseItemDataTable->setModaltype($data['modal_type']);
        // }
        return $expenseItemDataTable->render('home', $data);
    }

    public function show($id) //view('expenseItem.show')
    {
        if(request()->ajax()) {
            $data['expenseItem'] = ExpenseItem::findorfail($id);
            return view('expenseItem.show', $data)->render();
        } else abort(404);
    }

    public function create() //view('expenseItem.create')
    {
        $data = ['title' => 'New Expense Type', 'page' => 'expenseItem.create'];
        return view('home', $data);
    }

    public function edit($id) //view('expenseItem.edit')
    {
        $data = ['title' => 'Edit Expense Type', 'page' => 'expenseItem.edit'];
        $data['expenseItem'] = ExpenseItem::findorfail($id);    
        return view('home', $data);
    }

    public function update(Request $request, $id)
    {
        self::validation($request, $id);
        $expenseItem = self::upstore($request, $id);
        BackupExpenseItem::store($expenseItem);
        return redirect()->route('expense-item.index')->with(['message' => 'Expense Item Update Successfully', 'alert-type' => 'success']);
    }

    public function store(Request $request)
    {
        self::validation($request);
        $expenseItem = self::upstore($request);
        if(request()->ajax()) return response()->json(['message' => 'Expense Type Create Successfully', 'alert-type' => 'success', 'expenseitem' => $expenseItem]);
        return redirect()->route('expense-item.index')->with(['message' => 'Expense Type Create Successfully', 'alert-type' => 'success']);
    }

    private static function validation($request, $id = null) 
    {
        $validate['title'] = ['required'];
        $validate['heading.*'] = ['required'];
        $validate['describe.*'] = ['required'];
        if(!is_null($id)) $validate['comment'] = ['required'];
        $request->validate($validate, [ 'heading' => 'Please fill up all heading.', 'describe' => 'Please fill up all describtion.' ]);
    }

    private static function upstore($request, $id = null) 
    {
        $input = $request->all();
        $other = array();
        foreach ($input['heading'] as $key => $heading) $other[] = ['heading' => $heading, 'describe' => $input['describe'][$key]]; 
        if(!is_null($id)) {
            $expenseItem = ExpenseItem::findorfail($id);
            $expenseItem->comment = $input['comment'];
        } else $expenseItem = new ExpenseItem();
        $expenseItem->title = $input['title'];
        $expenseItem->other = json_encode($other);
        $expenseItem->entry = auth()->id();
        $expenseItem->save();
        return $expenseItem;
    }

    public function search(Request $request)
    {
        $investors = ExpenseItem::query();
        $investors = $investors->where('title', 'like', '%'. $request->get('query'). '%');
        $investors = $investors->get(['id', 'title']);
        if(count($investors) == 1) {
            $data['expenseItem'] = ExpenseItem::find($investors->first()->id);
            $data['view'] = view('expense.expenseInfo', $data)->render();
            return response()->json($data);
        } 
        return response()->json(['expenseItems' => $investors]);
    }
}
