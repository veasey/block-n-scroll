<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeam;
use App\Models\Coach;
use App\Models\League;

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
}
