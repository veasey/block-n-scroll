<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\MatchGame;
use App\Models\Coach;
use App\Models\TeamLeagueRequest;

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

    public function requests()
    {
        return $this->hasMany(TeamLeagueRequest::class, 'league_id');
    }
}
