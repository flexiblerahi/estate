<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RolesSeeder extends Seeder
{
    public function run(): void
    {
        $nowtime = now()->toDateTimeString();
        DB::table('roles')->insert([
            ['name' => 'General Manger', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
            ['name' => 'Accountant', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
            ['name' => 'Share Holder', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
            ['name' => 'Agent', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
            ['name' => 'Customer', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
            ['name' => 'Investor', 'guard_name' => 'web', 'created_at' => $nowtime, 'updated_at' => $nowtime],
        ]);
    }
}