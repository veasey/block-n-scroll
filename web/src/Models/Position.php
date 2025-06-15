<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Position extends Model
{
    protected $table = 'player_position';
    protected $fillable = [
        'player_id'
    ];
}
