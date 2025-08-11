<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeamPlayer as Position;
use App\Models\Base\Skill;
use App\Models\Team;

class Player extends Model
{
    protected $table = 'player';
    
    public function position() 
    {
        return $this->belongsTo(Position::class, 'base_team_player_id');
    }

    public function team(): mixed 
    {
        return $this->belongsTo(Team::class, 'team_id');
    }

    public function skills(): mixed
    {
        return $this->belongsToMany(
            Skill::class,
            'player_skill',
            'player_id',
            'skill_id'
        );
    }
}
