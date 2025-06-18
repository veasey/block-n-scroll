<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeamPlayer;
use App\Models\Base\RaceSpecialRule as SpecialRule;
use App\Models\Base\RegionalSpecialRule as RegionalRule;

class BaseTeam extends Model
{
    protected $table = 'base_team';
    
    public function players()
    {
        return $this->hasMany(BaseTeamPlayer::class, 'base_team_id');
    }

    public function special_rules()
    {
        return $this->belongsToMany(
            SpecialRule::class,
            'base_team_special_rule',    // Pivot table name
            'base_team_id',       // Foreign key on pivot table for this model
            'special_rule_id'                   // Foreign key on pivot table for Skill
        );
    }

    public function regional_rules()
    {
        return $this->belongsToMany(
            RegionalRule::class,
            'base_team_regional_rule',    // Pivot table name
            'base_team_id',       // Foreign key on pivot table for this model
            'regional_rule_id'                   // Foreign key on pivot table for Skill
        );
    }
}
