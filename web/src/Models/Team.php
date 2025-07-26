<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeam;
use App\Models\Coach;
use App\Models\League;
use App\Models\Player;

class Team extends Model
{
    protected $table = 'team';

    public function baseTeam()
    {
        return $this->belongsTo(BaseTeam::class, 'base_team_id');
    }

    public function coach()
    {
        return $this->belongsTo(Coach::class, 'coach_id');
    }

    public function league(): mixed
    {
        return $this->belongsTo(League::class, 'league_id');
    }

    public function players(): mixed
    {
        return $this->hasMany(Player::class, 'team_id');
    }
}
