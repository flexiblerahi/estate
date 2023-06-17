<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BackupExpenseItem extends Model
{
    use HasFactory;

    public static function store($expenseItem)
    {
        $backupExpenseItem = new self;
        $backupExpenseItem->expense_item_id = $expenseItem->id;
        $backupExpenseItem->title = $expenseItem->title;
        $backupExpenseItem->other = json_encode($expenseItem->other);
        $backupExpenseItem->entry = $expenseItem->entry;
        $backupExpenseItem->comment = $expenseItem->comment;
        $backupExpenseItem->save();
    }
}
