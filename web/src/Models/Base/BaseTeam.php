<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeamPlayer;
use App\Models\Base\CategoryRaceSpecialRule as SpecialRule;
use App\Models\Base\CategoryRegionalSpecialRule as RegionalRule;

class BaseTeam extends Model
{
    protected $table = 'base_team';
    
    public function players()
    {
        return $this->hasMany(BaseTeamPlayer::class, 'base_team_id');
    }

    public function special_rule()
    {
        return $this->hasOne(SpecialRule::class, 'id', 'category_race_special_rule_id');
    }

    public function regional_rule()
    {
        return $this->hasOne(RegionalRule::class, 'id', 'category_regional_special_rule_id');
    }
}
