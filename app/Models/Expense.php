<?php

namespace App\Models;

use App\Traits\Entrytraits;
use App\Traits\TransactionBanktraits;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Expense extends Model
{
    use HasFactory, TransactionBanktraits, Entrytraits;

    public function type()
    {
        return $this->belongsTo(ExpenseItem::class, 'expense_item_id', 'id');
    }

    public function getCreatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }

    public function getUpdatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }
}
