<?php

namespace App\DataTables;

use App\Models\Withdraw;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class WithdrawDataTable extends DataTable
{
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->addColumn('action', function($query) {
                $tag = '<a class="btn-sm btn-primary mr-1" href="' . route('withdraw.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                return $tag;
            })
            ->addColumn('entry_id', function($query) {
                return '<p>Name'. $query->entry->name . '<br>Phone:'.$query->entry->phone.'</p>';
            })
            ->addColumn('user_details_id', function($query) {
                return '<p>'. $query->user->name . '<br>Phone:'.$query->user->phone.'</p>';
            })
            ->addColumn('created_at', function ($query) {
                return \Carbon\Carbon::parse($query->created_at)->format('d M Y');
            })
            ->addColumn('withdraw_at', function ($query) {
                return \Carbon\Carbon::parse($query->withdraw_at)->format('d M Y');
            })
            ->rawColumns(['action', 'entry_id', 'user_details_id', 'created_at', 'withdraw_at']);
    }

    public function query(Withdraw $model): QueryBuilder
    {
        return $model->with('entry', 'user')->newQuery();
    }

    public function html(): HtmlBuilder
    {
        return $this->builder()
                    ->setTableId('withdraw-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->orderBy(1)
                    ->selectStyleSingle()
                    ->dom('Bfrtip')
                    ->buttons([
                        Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;Create')
                    ]);
    }

    public function getColumns(): array
    {
        return [
            Column::make('user_details_id')->name('user.phone')->title('User'),
            Column::make('amount'),
            Column::make('entry_id')->name('entry.phone')->title('Entrier'),
            Column::make('withdraw_at')->title('Withdraw At'),
            Column::make('created_at'),
            Column::computed('action'),
        ];
    }

    protected function filename(): string
    {
        return 'Withdraw_' . date('YmdHis');
    }
}
