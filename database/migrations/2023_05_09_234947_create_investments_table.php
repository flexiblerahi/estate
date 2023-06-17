<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('investments', function (Blueprint $table) {
            $table->id();
            $table->string('account_id', 500)->unique();
            $table->foreignId('investor_id')->constrained('investors')->cascadeOnDelete();
            $table->string('document')->nullable();
            $table->integer('rate')->default(0);
            $table->integer('duration')->default(0);
            $table->string('duration_in');
            $table->date('invest_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('investments');
    }
};
