<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserDetail;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function index()//view('profile')
    {
        // dd('fd');
        $data['user'] = auth()->user();
        $data['user_details'] = $data['user']->userdetails;
        $data['page'] = 'profile';
        $data['title'] = 'Profile | total income: '. $data['user_details']->income;
        return view('home', $data);
    }

    public function validation($request, $user_details)
    {
        $validation['name'] =  'required|string|max:255';
        $validation['email'] = 'required|string|email|unique:users,email,' . auth()->id();    
        $validation['phone'] = 'required';
        $validation['account_id'] = 'required';
        $validation['image'] =  'image';
        if(!is_null($request->input('password'))) $validation['password'] = ['min:4', 'same:confirm-password'];
        $request->validate($validation);
    }
    public function store(Request $request)
    {
        $user_details = UserDetail::where(['user_id' => auth()->id()])->first();
        $this->validation($request, $user_details);
        $input = $request->all();
        if(!is_null($input['password'])) $input['password'] = bcrypt($input['password']);
        $user = User::find(auth()->id());
        $user->email = $input['email'];
        $user->save();
        $user_details->name = $input['name'];
        $user_details->account_id = UserDetail::PROFILEROLE[$user_details->role].$input['account_id'];
        $user_details->phone = $input['phone'];
        $user_details->present_address = $input['present_address'];
        $user_details->permanent_address = $input['permanent_address'];
        $user_details->emergency_contact =  $input['emergency_contact'];
        $user_details->occupation = $input['occupation'];
        $user_details->parent_name = json_encode(['father' => $input['father'], 'mother' => $input['mother']]);
        $user_details->image = uploadFile($request->image, '/profile', $user_details->image);
        $user_details->save();
        return redirect()->route('user.profile.index', $user_details->account_id)->with(['message' =>'Profile Updated Successfully', 'alert-type' => 'success']);
    }
}
