<?php

namespace App\DataTables;

use App\Models\Expense;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class ExpenseDataTable extends DataTable
{
    public $modal_type;

    public function setModaltype($modal_type = '')
    {
        $this->modal_type = $modal_type;
    }

    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->addColumn('title', function($query) {
                return '<p>'. $query->type->title.'</p>';
            })
            ->addColumn('created_at', function($query) {
                return '<p>'. $query->created.'</p>';
            })
            ->addColumn('amount', function($query) {
                return '<p>'. abs($query->bank_transaction->amount).'</p>';
            })
            ->addColumn('action', function($query) {
                $tag = '';
                // if(auth()->user()->can('investment-edit')) {
                    $tag .= '<a class="btn-sm btn-primary mr-1" href="' . route('expense.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                // }
                // if(auth()->user()->can('investment-view')) {
                    $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-toggle="modal" data-target="#'.$this->modal_type.'Id" data-link="' . route('expense.show', $query->id) . '"><i class="far fa-eye"></i></a>';
                // }
                return $tag;
            })
            ->rawColumns(['action', 'created_at', 'title', 'amount']);
    }

    public function query(Expense $model): QueryBuilder
    {
        return $model->with('type', 'bank_transaction')->newQuery();
    }

    public function html(): HtmlBuilder
    {
        $builder = $this->builder()
                    ->setTableId('expense-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->orderBy(1)
                    ->selectStyleSingle();
        // if(auth()->user()->can('new-investment')) {
            $builder = $builder->dom('Bfrtip')->buttons([ Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;Create') ]);
        // }
        return $builder;
    }

    public function getColumns(): array
    {
        $columns = [
            Column::make('id'),
            Column::make('created_at')->title('Created At'),
            Column::make('title')->name('type.title')->title('Title'),
            Column::make('amount')->name('bank_transaction.amount')->title('Amount')
        ];
        // if(auth()->user()->canany(['investment-view', 'investment-edit'])) {
            $columns[] = Column::make('action');
        // }
        return $columns;
    }

    protected function filename(): string
    {
        return 'Expense_' . date('YmdHis');
    }
}
