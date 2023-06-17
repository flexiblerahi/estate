<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    use HasFactory;

    public static function store($sale, $input)
    {
        $sale->price = $input['price'];
        $sale->sector = $input['sector'];
        $sale->block = $input['block'];
        $sale->road = $input['road'];
        $sale->plot = $input['plot'];
        $sale->kata = $input['kata'];
        $sale->date = formatdate($input['saledate']);
        $sale->type = $input['type'];
        $sale->entry = auth()->id();
        // dd($sale);
        $sale->save();
        return $sale;
    }

    public function customer()
    {
        return $this->belongsTo(UserDetail::class, 'customer_id', 'id');
    }

    public function shareholder()
    {
        return $this->belongsTo(UserDetail::class, 'shareholder_id', 'id');
    }

    public function agent()
    {
        return $this->belongsTo(UserDetail::class, 'agent_id', 'id');
    }

    public static function getDetails($id = null, $uuid = null)
    {
        $sale = self::with('customer');
        $sale = (is_null($id)) ? $sale->where('uuid', $uuid) : $sale->where('id', $id);
        $data['sale'] = $sale = $sale->firstOrFail();
        $data['commissions'] = $commissions = json_decode($sale->commission, 1);
        $data['referencesIds'] = $referencesIds = array_map(fn($item) => isset($item['agent_id']) ? $item['agent_id'] : $item['shareholder_id'], $commissions['installment']);
        $data['referenceUsers'] = $referenceUsers = UserDetail::query()->whereIn('account_id', $referencesIds)->select('account_id', 'role', 'name', 'phone', 'emergency_contact', 'total_kata', 'id')->get();
        $data['commission_names'] = Commission::VARIABLEKEYS;
        $userId = (is_null($sale->agent_id)) ? $sale->shareholder_id : $sale->agent_id;
        $data['user'] = $referenceUsers->find($userId);
        $data['rank'] = countRank($data['user']->total_kata);
        return $data;
    }
}
