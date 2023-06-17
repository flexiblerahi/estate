<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('backup_investments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('investment_id')->constrained('investments');
            $table->foreignId('investor_id')->constrained('investors')->cascadeOnDelete();
            $table->string('document')->nullable();
            $table->integer('rate')->default(0);
            $table->integer('duration')->default(0);
            $table->string('duration_in');
            $table->date('invest_at')->nullable();
            $table->text('comment')->nullable();
            $table->foreignId('entry')->constrained('user_details');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('backup_investments');
    }
};
