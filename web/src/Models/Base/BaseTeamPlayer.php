<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

class BaseTeamPlayer extends Model
{
    protected $table = 'base_team_player';
    protected $fillable = [
        'base_team_player_id'
    ];
}
