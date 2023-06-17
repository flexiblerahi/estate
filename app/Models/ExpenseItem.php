<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpenseItem extends Model
{
    use HasFactory;

    public function entrier()
    {
        return $this->belongsTo(UserDetail::class, 'entry', 'id');
    }

    public function getCreatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }

    public function getUpdatedAttribute()
    {
        return \Carbon\Carbon::parse($this->created_at)->format('d M Y');
    }

    public function getOtherAttribute($value)
    {
        return json_decode($value, 1);
    }
}
