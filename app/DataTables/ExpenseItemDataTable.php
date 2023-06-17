<?php

namespace App\DataTables;

use App\Models\ExpenseItem;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class ExpenseItemDataTable extends DataTable
{
    public $modal_type;

    public function setModaltype($modal_type = '')
    {
        $this->modal_type = $modal_type;
    }

    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
                ->addColumn('created_at', function ($query) {
                    return $query->created;
                })
                ->addColumn('updated_at', function ($query) {
                    return $query->updated;
                })
                ->addColumn('action', function($query) {
                    $tag = '';
                    // if(auth()->user()->can('bank-info-edit')) {
                        $tag .= '<a class="btn-sm btn-primary mr-1" href="' . route('expense-item.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                    // }
                    // if(auth()->user()->can('bank-info-view')) {
                        $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-toggle="modal" data-target="#'.$this->modal_type.'Id" data-link="' . route('expense-item.show', $query->id) . '"><i class="far fa-eye"></i></a>';
                    // }
                    return $tag;
                })
                ->addColumn('entry', function($query) {
                    return '<p>'.$query->entrier->name.'</p>';
                }) 
                ->rawColumns(['created_at', 'updated_at', 'action', 'entry']);
    }

    public function query(ExpenseItem $model): QueryBuilder
    {
        return $model->with('entrier:id,name')->newQuery();
    }

    public function html(): HtmlBuilder
    {
        $builder =  $this->builder()
                    ->setTableId('expenseitem-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->orderBy(1)
                    ->selectStyleSingle();
        // if(auth()->user()->can('new-bank-info')) {
            $builder = $builder->dom('Bfrtip')->buttons([ Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;Create') ]);
        // }
        return $builder;
    }

    public function getColumns(): array
    {
        $columns = [
            Column::make('id'),
            Column::make('title'),
            Column::make('created_at'),
            Column::make('updated_at'),
            Column::make('entry')->name('entry.name')
        ];
        // if(auth()->user()->canany(['bank-info-view', 'bank-info-edit'])) {
            $columns[] = Column::make('action')->width('100px');
        // }
        return $columns;
    }

    protected function filename(): string
    {
        return 'ExpenseItem_' . date('YmdHis');
    }
}
