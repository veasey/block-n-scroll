<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeamPlayer;
use App\Models\Base\CategorySpecialRaceRule as SpecialRule;
use App\Models\Base\CategorySpecialRegionalRule as RegionalRule;

class BaseTeam extends Model
{
    protected $table = 'base_team';

    public function findById($id)
    {
        return self::where('base_team_id', $id)->first();
    }

    public function players()
    {
        return $this->hasMany(BaseTeamPlayer::class, 'base_team_id');
    }

    public function special_rules()
    {
        return $this->hasOne(SpecialRule::class, 'base_team_id');
    }

    public function regional_rules()
    {
        return $this->hasOne(RegionalRule::class, 'base_team_id');
    }
}
