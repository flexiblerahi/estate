<?php

namespace App\DataTables;

use App\Models\Investor;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class InvestorDataTable extends DataTable
{
    public $modal_type;

    public function setModaltype($modal_type = '') {
        $this->modal_type = $modal_type;
    }
    
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->addColumn('created_at', function ($query) {
                return \Carbon\Carbon::parse($query->created_at)->format('d M Y');
            })
            ->addColumn('updated_at', function ($query) {
                return \Carbon\Carbon::parse($query->updated_at)->format('d M Y');
            })
            ->addColumn('action', function($query) {
                $tag = '';
                if(auth()->user()->can('investor-edit')) {
                    $tag .= '<a class="btn-sm btn-primary mr-1" href="' . route('investor.edit', $query->id) . '"><i class="far fa-edit"></i></a>';
                }
                if(auth()->user()->can('investor-view')) {
                    $tag .= '<a class="btn-sm btn-primary showmodal text-white mr-1" data-toggle="modal" data-target="#'.$this->modal_type.'Id" data-link="' . route('investor.show', $query->id) . '"><i class="far fa-eye"></i></a>';
                }
                return $tag;
            })
            ->addColumn('status', function($query) {
                if ($query->status == 1) return '<div class="btn btn-success btn-sm">Active</div>';
                return '<div class="btn btn-danger btn-sm"> Deactive</div>';
            }) 
            ->rawColumns(['created_at', 'updated_at', 'action', 'status']);
    }

    public function query(Investor $model): QueryBuilder
    {
        return $model->newQuery();
    }

    public function html(): HtmlBuilder
    {
        $builder = $this->builder()
                    ->setTableId('investor-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->orderBy(1)
                    ->selectStyleSingle();
        if(auth()->user()->can('new-investor')) {
            $builder = $builder->dom('Bfrtip')->buttons([
                Button::make('create')->text('<i class="fa fa-plus"></i>&nbsp;Create'),
            ]);
        }
        
        return $builder;
    }

    public function getColumns(): array
    {
        $columns =  [
            Column::make('id'),
            Column::make('name'),
            Column::make('phone'),
            Column::make('created_at')->title('Register At'),
            Column::make('updated_at'),
            Column::make('status'),
        ];
        if(auth()->user()->canany(['investor-view', 'investor-edit'])) {
            $columns[] = Column::make('action');
        }
        return $columns;
    }

    protected function filename(): string
    {
        return 'Investor_' . date('YmdHis');
    }
}
