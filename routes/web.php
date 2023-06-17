<?php

use Illuminate\Support\Facades\Route;

Route::get('/register', [App\Http\Controllers\UserController::class, 'register'])->name('register');
Route::get('/login', [App\Http\Controllers\UserController::class, 'login'])->name('login');
Route::get('forgot-password', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'create'])->name('password.request');
Route::post('forgot-password', [App\Http\Controllers\Auth\ForgotPasswordController::class, 'store'])->name('password.email');
Route::get('reset-password/{token}', [App\Http\Controllers\Auth\NewPasswordController::class, 'create'])->name('password.reset');
Route::post('reset-password', [App\Http\Controllers\Auth\NewPasswordController::class, 'store'])->name('password.update');
Route::post('/registration', [App\Http\Controllers\UserController::class, 'usercreate'])->name('registration');
Route::post('/login/check', [App\Http\Controllers\UserController::class, 'checkLogin'])->name('login.check');
Route::post('/logout', [App\Http\Controllers\UserController::class, 'logout'])->name('logout');

Route::group(['middleware' => 'auth'], function () {
    Route::get('/user-profile/{account_id}', [App\Http\Controllers\ProfileController::class, 'index'])->name('user.profile.index');
    Route::post('/user-profile', [App\Http\Controllers\ProfileController::class, 'store'])->name('user.profile.store');
    Route::get('/', [App\Http\Controllers\HomeController::class, 'dashboard'])->name('home');
    Route::resource('commission', App\Http\Controllers\CommissionController::class)->except(['create', 'store']);
    Route::get('setting', [App\Http\Controllers\SettingController::class, 'index'])->name('setting.index');
    Route::put('setting/update/{id}', [App\Http\Controllers\SettingController::class, 'update'])->name('setting.update');
    Route::resource('roles',   App\Http\Controllers\RoleController::class);
    Route::resource('sale', App\Http\Controllers\SaleController::class)->except('destroy');
    Route::get('status-update', [App\Http\Controllers\UserDetailController::class, 'updatestatus'])->name('update-status');
    Route::resource('user-detail', App\Http\Controllers\UserDetailController::class);
    Route::get('search-user', [App\Http\Controllers\UserDetailController::class, 'usersearch']);
    Route::resource('deposit-payment', App\Http\Controllers\DepositPaymentController::class);
    Route::get('deposit-old-payment', [App\Http\Controllers\DepositPaymentController::class, 'oldpayment'])->name('old-payment');
    Route::resource('withdraw', App\Http\Controllers\WithdrawController::class);

    /// start 2.0 work
    Route::resource('investor', App\Http\Controllers\InvestorController::class)->except('destroy');
    Route::resource('bank-info', App\Http\Controllers\BankInfoController::class)->except('destroy');
    Route::group(['prefix' => 'pos'], function() { //investment url not working directly that's why use prefix pos
        Route::resource('investment', App\Http\Controllers\InvestmentController::class)->except('destroy'); //pending
        Route::resource('expense', App\Http\Controllers\ExpenseController::class)->except('destory');
    });
    Route::resource('land-purchase', App\Http\Controllers\LandPurchaseController::class)->except('destroy');
    Route::resource('bank-transaction', App\Http\Controllers\BankTransactionController::class)->except('destroy'); //pending
    Route::get('search-investor', [App\Http\Controllers\InvestorController::class, 'search']);
    Route::get('search_bank', [App\Http\Controllers\BankInfoController::class, 'search_bank']);
    Route::resource('expense-item', App\Http\Controllers\ExpenseItemController::class)->except('destory');
    Route::get('search-expense-item', [App\Http\Controllers\ExpenseItemController::class, 'search']);
    // start 3.0 work
    Route::resource('bank-name', App\Http\Controllers\BankNameController::class);
    Route::resource('deposit-other', App\Http\Controllers\DepositOtherController::class);
    Route::resource('employee', App\Http\Controllers\EmployeeController::class);
    Route::resource('salary', App\Http\Controllers\SalaryController::class);
    Route::resource('salary-type', App\Http\Controllers\SalaryTypeController::class);
    //end
    Route::group(['prefix' => 'report', 'as' => 'report.'], function () {
        Route::get('/', [App\Http\Controllers\ReportController::class, 'index'])->name('index');
        Route::get('/customer-list', [App\Http\Controllers\ReportController::class, 'customersReport'])->name('customer');
        Route::get('/agent-list', [App\Http\Controllers\ReportController::class, 'agentsReport'])->name('agent');
        Route::get('/agent-details-list', [App\Http\Controllers\ReportController::class, 'agentsDetailsReport'])->name('agent.details');
        Route::get('/shareholder-list', [App\Http\Controllers\ReportController::class, 'shareholdersReport'])->name('shareholder');
        Route::get('/sale-list',[App\Http\Controllers\ReportController::class, 'saleReport'])->name('sale');
        Route::get('/deposit-list',[App\Http\Controllers\ReportController::class, 'depositReport'])->name('deposit');
        Route::get('/withdraw-list',[App\Http\Controllers\ReportController::class, 'withdrawReport'])->name('withdraw');
        Route::get('/transaction-list',[App\Http\Controllers\ReportController::class, 'transactionReport'])->name('transaction');
        Route::get('/user-info', [App\Http\Controllers\ReportController::class, 'userInfo'])->name('user.info');
        Route::post('/all', [App\Http\Controllers\ReportController::class, 'all'])->name('all');
    });
});
