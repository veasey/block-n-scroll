<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class League extends Model
{
    protected $table = 'league';

    public function coaches()
    {
        return $this->belongsToMany(Coach::class, 'league_coach')
                    ->withTimestamps();
    }
}
