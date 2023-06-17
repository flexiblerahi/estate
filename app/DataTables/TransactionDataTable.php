<?php

namespace App\DataTables;

use App\Models\Transaction;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class TransactionDataTable extends DataTable
{
    public $modal_type;

    public function setModaltype($modal_type = '') { $this->modal_type = $modal_type; }

    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
                ->addColumn('action', function($query) {
                    $tag = '';
                    if(auth()->user()->can('withdraw-edit')) {
                        $tag .= '<a class="btn-sm btn-primary mr-1" href="' . route('withdraw.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                    }
                    $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-toggle="modal" data-target="#'.$this->modal_type.'Id" data-link="' . route('withdraw.show', $query->id) . '"><i class="far fa-eye"></i></a>';
                    return $tag;
                })
                ->addColumn('user_details_id', function($query) {
                    return '<p>'. $query->user->name . '<br><span class="font-weight-bold">Phone: </span>'.$query->user->phone.'</p>';
                })
                ->addColumn('date', function ($query) {
                    return getdateformat($query->date);
                })
                ->addColumn('amount', function ($query) {
                    return abs($query->amount);
                })
                ->rawColumns(['action', 'user_details_id', 'date', 'amount']);
    }

    public function query(Transaction $model): QueryBuilder
    {
        $model = $model->with('entrier', 'user');
        $model = (str_contains(request()->url(), 'withdraw')) ? $model->where('status', 0) : $model->where('status', 1);
        return $model->latest();
    }

    public function html(): HtmlBuilder
    {
        $builder = $this->builder()
                    ->setTableId('withdraw-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->orderBy(1)
                    ->selectStyleSingle();
        if(auth()->user()->can('new-withdraw')) {
            $builder = $builder->dom('Bfrtip')->buttons([Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;New Withdraw')]);
        }
        return $builder;
    }

    public function getColumns(): array
    {
        return [
            Column::make('date')->title('Withdraw At'),
            Column::make('amount'),
            Column::make('user_details_id')->name('user.phone')->title('User'),
            Column::computed('action')
        ];
    }

    protected function filename(): string
    {
        return 'Transaction_' . date('YmdHis');
    }
}
