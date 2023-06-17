<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Investor extends Model
{
    use HasFactory;

    public function getParentNameAttribute($value)
    {
        if(is_null($value)) {
            return (object) array('father' => null, 'mother' => null);
        }
        return json_decode($value);
    }

    public function getCreatedAttribute()
    {
        return Carbon::parse($this->created_at)->format('F j, Y');
    }

    public function getUpdatedAttribute()
    {
        return Carbon::parse($this->created_at)->format('F j, Y');
    }
}
