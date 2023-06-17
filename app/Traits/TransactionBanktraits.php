<?php

namespace App\Traits;

use App\Models\BankTransaction;

trait TransactionBanktraits
{
    public function bank_transaction()
    {
        return $this->morphOne(BankTransaction::class, 'model');
    }

    public function transaction()
    {
        return $this->morphOne(Transaction::class, 'model');
    }
}