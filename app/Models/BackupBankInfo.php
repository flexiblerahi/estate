<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BackupBankInfo extends Model
{
    use HasFactory;

    public static function store($bank_info, $comment)
    {
        $backup_bank_info = new self;
        $backup_bank_info->attributes = $bank_info->attributes;
        $backup_bank_info->bank_info_id = $bank_info->id;
        $backup_bank_info->comment = $comment;
        $backup_bank_info->save();
    }
}
