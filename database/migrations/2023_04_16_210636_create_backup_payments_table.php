<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('backup_payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_id')->constrained('payments');
            $table->foreignId('sale_id')->constrained('sales');
            $table->json('commission')->nullable();
            $table->string('commission_type');
            $table->integer('percentage')->default(0);
            $table->text('comment')->nullable();
            $table->foreignId('entry')->constrained('user_details');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('backup_payments');
    }
};
