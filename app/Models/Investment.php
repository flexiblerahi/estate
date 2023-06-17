<?php

namespace App\Models;

use App\Traits\TransactionBanktraits;
use App\Traits\Entrytraits;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Investment extends Model
{
    use HasFactory, TransactionBanktraits, Entrytraits;

    public function investor()
    {
        return $this->belongsTo(Investor::class);
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
