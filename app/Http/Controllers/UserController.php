<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserDetail;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    public function register()
    {
        $data['roles'] = Role::all();
        $data['page_title'] = 'User Register';
        return view('auth.register', $data);
    }

    public function login()
    {
        $data['page_title'] = 'User Login';
        return view('auth.login', $data);
    }

    protected function usercreate(Request $request)
    {
        $input = $request->validate([
            'name' => 'required',
            'phone' => 'required|unique:user_details,phone',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|same:confirm_password|min:4',
            'role' => 'required',
        ]);
        
        try {
            $type = UserDetail::TYPE[$request->role];
            $role = UserDetail::USER[$request->role];
        } catch(Exception $e) {return redirect()->back()->with(['message' => 'Undefined Role', 'alert-type' => 'error']);}
        $user = User::create([ 'email' => $input['email'], 'password' => Hash::make($input['password']) ]);
        $user->assignRole(ucfirst($request->role));

        $accountId =(int) UserDetail::latest()->first()->id + 1;
        UserDetail::create([ 'account_id' => $accountId, 'user_id' => $user->id, 'name' => $input['name'], 'phone' => $input['phone'], 'role' => $role ]);
        return redirect()->route('login')->with(['message'=>'please wait for account confirmation','alert-type'=>'warning']);
    }

    public function checkLogin(Request $request)
    {
        $input= $request->validate([ 'email' => 'required|email', 'password' => 'required' ]); 
        if (Auth::attempt(['email' => $input['email'], 'password' => $input['password']], $request->get('remember'))) {
            session()->put(['message'=>'login Successfully','alert-type'=>'success']);
            if(auth()->user()->status == 0) {
                auth()->logout();
                session()->put(['message'=>'Your Account not active yet.','alert-type'=>'error']);
                return back();
            }
            return redirect()->route('home');
        }
        session()->put(['message'=>'credencial does not match','alert-type'=>'error']);
        return back();
    }

    public function logout()
    {
        Session::flush();
        Auth::logout();
        return redirect('login');
    }
}
