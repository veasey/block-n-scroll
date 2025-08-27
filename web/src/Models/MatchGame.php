<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Team;

class MatchGame  extends Model
{
    protected $table = 'game';

    public function homeTeam() 
    {
        return $this->belongsTo(Team::class, 'home_team_id');
    }

    public function awayTeam() 
    {
        return $this->belongsTo(Team::class, 'away_team_id');
    }
}
