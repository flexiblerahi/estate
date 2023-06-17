<?php

namespace App\Http\Controllers;

use App\DataTables\LandPurchaseDataTable;
use App\Models\LandPurchase;
use Illuminate\Http\Request;

class LandPurchaseController extends Controller
{
    public function __construct() {
        $this->middleware('permission:land-purchase-list|new-land-purchase|land-purchase-edit|land-purchase-view', ['only' => ['index', 'create', 'store', 'edit', 'update', 'show']]);
        $this->middleware('permission:new-land-purchase', ['only' => ['create', 'store']]);
        $this->middleware('permission:land-purchase-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:land-purchase-view', ['only' => ['show']]);
    }

    public function index(LandPurchaseDataTable $landPurchaseDataTable) //view('landpurchase.create') //view('modules.modal')
    {
        $data['page'] = 'index';
        $data['title'] = 'Land Purchases';
        if(auth()->user()->can('land-purchase-view')) {
            $data['modal'] = 'modules.modal';
            $data['modal_title'] = 'Land Purchase Profile';
            $data['modal_type'] = 'landpurchase';
            $landPurchaseDataTable->setModaltype($data['modal_type']);
        }
        return $landPurchaseDataTable->render('home', $data);
    }

    public function show($id)
    {
        if(request()->ajax()) {
            $data['landpurchase'] = LandPurchase::with('entrier')->findorfail($id);
            return view('landpurchase.show', $data)->render();    
        } else abort(404);
    }

    public function create() //view('landpurchase.create')
    {
        $data['title'] = 'New Land Purchase';
        $data['page'] = 'landpurchase.create';
        return view('home', $data);
    }
    
    public function edit($id) //view('landpurchase.edit')
    {
        $data['landPurchase'] = LandPurchase::findorfail($id);
        $data['title'] = 'New Land Purchase';
        $data['page'] = 'landpurchase.edit';
        return view('home', $data);
    }

    public function store(Request $request)
    {
        self::validation($request);
        self::upstore($request);
        return redirect()->route('land-purchase.index')->with(['message' => 'Land Purchase Create Successfully.', 'alert-type' => 'success']);
    }

    public function update(Request $request, $id)
    {
        self::validation($request);
        self::upstore($request, $id);
        return redirect()->route('land-purchase.index')->with(['message' => 'Land Purchase Updated Successfully.', 'alert-type' => 'success']);
    }

    private static function validation($request)
    {
        $validate['land'] = ['required'];
        $validate['amount'] = ['required'];
        $validate['mouza'] = ['required'];
        $validate['giver'] = ['required'];
        $validate['taker'] = ['required'];
        $validate['rs'] = ['required'];
        $validate['sa'] = ['required'];
        $validate['document'] = ['required'];
        $request->validate($validate);
    }

    private static function upstore($request, $id = null) 
    {
        $input = $request->all();
        $land_purchase = new LandPurchase();
        if(is_null($id)) {
            $land_purchase = new LandPurchase();
            $previous_land = LandPurchase::latest()->first();
            $documment_id = is_null($previous_land) ? randomnumbers(0) : randomnumbers($previous_land->id);
        }
        else $land_purchase = LandPurchase::findorfail($id);
        $land_purchase->land = $input['land'];
        $land_purchase->amount = $input['amount'];
        $land_purchase->mouza = $input['mouza'];
        $land_purchase->giver = $input['giver'];
        $land_purchase->taker = $input['taker'];
        $land_purchase->rs = $input['rs'];
        $land_purchase->sa = $input['sa'];
        if($request->has('document')) {
            if(is_null($id)) $land_purchase->document = newuploadFile('landpurchase/', $documment_id, $input['document']);
            $land_purchase->document = newuploadFile('landpurchase/', $documment_id, $input['document'], $land_purchase->document);
        }
        $land_purchase->entry = auth()->id();
        $land_purchase->save();
    }
}
