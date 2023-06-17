<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use App\Models\Sale;
use App\Models\UserDetail;

class HomeController extends Controller
{
    public function dashboard()
    {
        $data['auth_user_details'] = auth()->user()->userdetails;
        $data['shareholder'] = UserDetail::where(['role'=> UserDetail::USER['shareholder'], 'status' => 1])->select('id', 'name', 'phone', 'income', 'total_kata')->get();
        $paymentweekly = Payment::query()->whereBetween('created_at', [now()->subWeek(), now()])->select('id', 'created_at')->oldest()->get();
        $paymentmonthly = Payment::whereMonth('created_at', '=', date('m'))->whereYear('created_at', '=', date('Y'))->select('id', 'created_at')->oldest()->get();
        $data['paymentmonthly'] = $paymentmonthly->groupBy(function ($item) {
            return $item->created_at->toDateString();
        })->mapWithKeys(function ($group, $date) {
            // return [$date => $group->sum('amount')];
            return [$date => 0];
        });
        $data['paymentweekly'] = $paymentweekly->groupBy(function ($item) {
            return $item->created_at->toDateString();
        })->mapWithKeys(function ($group, $date) {
            // return [$date => $group->sum('amount')];
            return [$date => 0];

        });
        $data['monthly'] = Sale::whereMonth('created_at', '=', date('m'))
        ->whereYear('created_at', '=', date('Y'))->select('id', 'price', 'kata', 'created_at')->get();
        $data['weekly'] = Sale::whereBetween('created_at', [now()->subWeek(), now()])->select('id', 'price', 'kata', 'created_at')->get();
        $data['title'] = 'Dashboard';
        $data['page'] = 'manager';
        
        return view('dashboard', $data);
    }
}
