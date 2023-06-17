<?php

namespace App\DataTables;

use App\Models\OtherDeposit;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class OtherDepositDataTable extends DataTable
{
    public $modal_type;

    public function setModaltype($modal_type = '') { $this->modal_type = $modal_type; }

    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
                ->addColumn('amount', function ($query) {
                    return $query->bank_transaction->amount;
                    // dd($query);
                    // return '';
                })
                ->addColumn('date', function ($query) {
                    return getdateformat($query->bank_transaction->date);
                    // return '';
                })
                ->addColumn('other', function($query) {
                    return is_null($query->other) ? '<p class="text-danger">No Info Added!</p>' : $query->other;
                })
                ->addColumn('action', function($query) {
                    $tag = '';
                    // if(auth()->user()->can('investment-edit')) {
                        $tag .= '<a class="btn-sm btn-primary mr-1" href="' . route('deposit-other.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                    // }
                    // if(auth()->user()->can('investment-view')) {
                        $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-toggle="modal" data-target="#'.$this->modal_type.'Id" data-link="' . route('deposit-other.show', $query->id) . '"><i class="far fa-eye"></i></a>';
                    // }
                    return $tag;
                })
                ->rawColumns(['action', 'date', 'amount', 'other']);
    }

    public function query(OtherDeposit $model): QueryBuilder
    {
        return $model->with('bank_transaction');
    }

    public function html(): HtmlBuilder
    {
        $build = $this->builder()
                        ->setTableId('otherdeposit-table')
                        ->columns($this->getColumns())
                        ->minifiedAjax()
                        ->orderBy(1)
                        ->selectStyleSingle();
        // if(auth()->user()->can('new-investment')) {
            $build = $build->dom('Bfrtip')->buttons([ Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;New Deposit') ]);
        // }
        return $build;
    }

    public function getColumns(): array
    {
        $columns =  [

            Column::make('account_id'),
            Column::make('other')->title('Other Info'),
            Column::make('amount')->name('bank_transaction.amount')->title('Amount'),
            Column::make('date')->name('bank_transaction.date')->title('Deposit at'),
        ];
        // if(auth()->user()->canany(['investment-view', 'investment-edit'])) {
            $columns[] = Column::make('action');
        // }
        return $columns;
    }

    protected function filename(): string
    {
        return 'OtherDeposit_' . date('YmdHis');
    }
}
