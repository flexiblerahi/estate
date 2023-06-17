<?php

namespace App\DataTables;

use App\Models\UserDetail;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class UserDetailDataTable extends DataTable
{
    private $user;
    
    public function __construct() {
        $this->user = request()->get('user');
    }
    
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        $column = new EloquentDataTable($query);
        $rawcolumns[] = 'status';
        $column = $column->addColumn('status', function ($query) {
                if(auth()->user()->can($this->user.'-edit')) {
                    $role = array_flip(UserDetail::USER);
                    if ($query->status == 1) return '<div class="btn btn-success btn-sm onstatus" data-status="'.$query->status.'" id="status-'.$query->id.'" data-url="'.route('update-status', ['user' => $role[$query->role], 'id' => $query->id]).'"> ' . 'Active' .' </div>';
                    return '<div class="btn btn-danger btn-sm onstatus" data-status="'.$query->status.'" id="status-'.$query->id.'" data-url="'.route('update-status', ['user' => $role[$query->role], 'id' => $query->id]).'"> '. 'Deactive' .' </div>';
                } else {
                    if ($query->status == 1) return '<div class="text-success">Active</div>';
                    return '<div class="text-danger"> Deactive</div>';
                }
                });
        if(in_array($this->user, ['shareholder', 'accountant'])) {   
            $rawcolumns[] = 'email';
            $column = $column->addColumn('email', function($query) {
                return "<p><a href='mailto:".$query->user->email."'>".$query->user->email."</a></p>";
            });
        }
        if(auth()->user()->canany([$this->user.'-view', $this->user.'-edit'])) {
            $rawcolumns[] = 'action';
            $column = $column->addColumn('action', function ($query) {
                        $role = array_flip(UserDetail::USER);
                        $tag = '';
                        if(auth()->user()->can($this->user.'-view')) {
                            $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-role="'.$this->user.'" data-toggle="modal" data-target="#'.$this->user.'Id" data-link="' . route('user-detail.show', [$query->id, 'user' => $this->user]) . '"><i class="far fa-eye"></i></a>';
                        }
                        if(auth()->user()->can($this->user.'-edit')) {
                            if(in_array($role[$query->role], ['agent', 'customer'])) $tag .= '<a class="btn-sm btn-primary" href="' . route('user-detail.edit',  [$query->id, 'user' => $role[$query->role]]) . '"><i class="far fa-edit"></i></a>';
                        }
                        return $tag;
                    });
        }
       
        $rawcolumns[] = 'created_at';
        $column = $column->addColumn('created_at', function ($query) {
                    return \Carbon\Carbon::parse($query->created_at)->format('d M Y');
                });
        return $column->rawColumns($rawcolumns);
    }

    public function query(UserDetail $model): QueryBuilder
    {
        $model = $model->where('role', UserDetail::USER[$this->user]);
        if(in_array($this->user, ['shareholder', 'accountant'])) $model = $model->with('user');
        return $model->latest();
    }

    public function html(): HtmlBuilder
    {
        $html = $this->builder()->setTableId($this->user.'-table')->scrollX(true)->columns($this->getColumns())->minifiedAjax()->orderBy(1)->selectStyleSingle();
        if(in_array($this->user, ['agent', 'customer']) && auth()->user()->can('new-'.$this->user)) {
            $html = $html->dom('Bfrtip')->buttons(
                Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;Create')->action("window.location = '".route('user-detail.create', ['user' => $this->user])."';")
            );
        }
        return $html;
    }

    public function getColumns(): array
    {
        $column[] = Column::make('account_id')->title('Account Id')->width('200px');
        $column[] = Column::make('name')->title('Name')->width('275px');
        if(in_array($this->user, ['shareholder', 'accountant'])) $column[] = Column::make('email')->name('user.email')->title('Email');
        if(in_array($this->user, ['agent', 'shareholder'])) $column[] = Column::make('total_kata')->title('Total Katha');
        if(in_array($this->user, ['agent', 'shareholder'])) $column[] = Column::make('income')->title('Current Balance');
        $column[] = Column::make('phone')->width('200px');
        $column[] = Column::make('status')->width('100px');
        $column[] = Column::make('created_at')->title('Register Date')->width('200px');
        if(auth()->user()->canany([$this->user.'-view', $this->user.'-edit'])) {
            $column[] = Column::make('action')->title('Action')->width('200px');
        }
        return $column;
    }

    protected function filename(): string
    {
        return ucfirst($this->user).'_' . date('YmdHis');
    }
}
