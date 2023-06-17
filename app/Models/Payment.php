<?php

namespace App\Models;

use App\Traits\TransactionBanktraits;
use App\Traits\Entrytraits;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;
    use Entrytraits, TransactionBanktraits;

    public function sale()
    {
        return $this->belongsTo(Sale::class, 'sale_id', 'id');
    }

    public function getCreatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }

    public function getPaymentTypeAttribute()
    {
        return Commission::VARIABLEKEYS[$this->commission_type];
    }
}


