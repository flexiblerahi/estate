<?php

namespace App\Models;

use App\Traits\Entrytraits;
use App\Traits\TransactionBanktraits;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OtherDeposit extends Model
{
    use HasFactory, TransactionBanktraits, Entrytraits;

    public function getCreatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }
}
