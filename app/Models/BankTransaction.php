<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BankTransaction extends Model
{
    use HasFactory;
    const JOINTABLES = array('bank_transaction', 'bank_transaction.bank_info', 'bank_transaction.bank_info.bankname');
    
    public function model() { $this->morphTo(); }

    public function bank_info()
    {
        return $this->belongsTo(BankInfo::class, 'bank_info_id', 'id');
    }

    public function getCustomDateAttribute()
    {
        return \DateTime::createFromFormat('Y-m-d', $this->date)->format('d M Y');
    }
}