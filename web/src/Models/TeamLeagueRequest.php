<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Team;
use App\Models\League;

class TeamLeagueRequest extends Model
{
    protected $table = 'team_league_request';

    public function team()
    {
        return $this->belongsTo(Team::class, 'team_id');
    }

    public function league()
    {
        return $this->belongsTo(League::class, 'league_id');
    }
}
