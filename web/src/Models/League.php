<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\MatchGame;

class League extends Model
{
    protected $table = 'league';

    public function coaches()
    {
        return $this->belongsToMany(Coach::class, 'league_coach')
                    ->withTimestamps();
    }

    public function matches()
    {
        return $this->hasMany(MatchGame::class, 'league_id');
    }
}
