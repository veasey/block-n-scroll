<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

class BaseTeamPlayer extends Model
{
    protected $table = 'base_team_player';
    protected $fillable = [
        'base_team_player_id'
    ];

    public function skills()
    {
        return $this->belongsToMany(
            Skill::class,
            'base_team_player_skill',    // Pivot table name
            'base_team_player_id',       // Foreign key on pivot table for this model
            'skill_id'                   // Foreign key on pivot table for Skill
        );
    }
}
