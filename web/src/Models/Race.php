<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Position;

class Race extends Model
{
    protected $table = 'races';

    public function positions()
    {
        return $this->hasMany(Position::class, 'race_id');
    }
}
