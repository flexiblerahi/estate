<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SettingController extends Controller
{
    public function index()
    {
        return view('settings.index');   
    }

    public function update(Request $request, $id)
    {
        dd($request->all());
    }
}
