<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // $this->call(RolesSeeder::class);
        $this->call(PermissionSeeder::class);
        // $this->call(RolePermissionTableSeeder::class);
        // $this->call(UserSeeder::class);
        // \App\Models\User::factory(10)->create();
        // $this->call(CommissionSeeder::class);
        // \App\Models\UserDetail::factory(30)->create();
    }
}
