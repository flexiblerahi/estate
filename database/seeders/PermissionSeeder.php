<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PermissionSeeder extends Seeder
{
    public function run(): void
    {
        $allpermissions = array();
        $allrolehaspermissions = array();
        $count_permissions = 0;
        $nowtime = now()->toDateTimeString();
        $permissions = [
            'sale-list', 'new-sale', 'sale-view', 'sale-edit', 'accountant-list', 'accountant-edit', 'accountant-view', 
            'shareholder-list', 'shareholder-edit', 'shareholder-view', 'agent-list', 'agent-view', 'new-agent', 'agent-edit',
            'customer-list', 'customer-view', 'new-customer', 'customer-edit',
            'payment-list', 'new-payment', 'old-payment-list', 'old-payment-edit',
            'withdraw-list', 'new-withdraw', 'withdraw-edit',
            'report-list', 'report-customers', 'report-agents', 'report-sale-total', 'report-sale-individual', 'report-deposit',
            'report-withdraw', 'report-transaction', 'commission-list', 'commission-view', 'commission-edit',
            'role-list', 'permission-edit',
            'investor-list', 'new-investor', 'investor-edit', 'investor-view',
            'bank-info-list', 'new-bank-info', 'bank-info-edit', 'bank-info-view',
            'land-purchase-list', 'new-land-purchase', 'land-purchase-edit', 'land-purchase-view',
            'investment-list', 'new-investment', 'investment-edit', 'investment-view',
            'bank-name-list', 'new-bank-name', 'bank-name-edit', 'bank-name-view',
        ];
        foreach ($permissions as $permission) {
            $allpermissions[] = array('name' => $permission, 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime);
            $count_permissions = $count_permissions + 1;
        }
        
        DB::table('permissions')->insert($allpermissions);
        
        for($i = 1; $i <= $count_permissions; $i++) {
            $allrolehaspermissions[] = array('permission_id' => $i, 'role_id' => 1);
        }
        DB::table('role_has_permissions')->insert($allrolehaspermissions);
    }
}
