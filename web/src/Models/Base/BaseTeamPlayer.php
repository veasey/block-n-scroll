<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

class BaseTeamPlayer extends Model
{
    protected $table = 'base_team_player';
    protected $fillable = [
        'base_team_player_id'
    ];

    public function primarySkills()
    {
        return $this->belongsToMany(
            SkillCategory::class,
            'base_team_player_skill_category',
            'base_team_player_id',
            'skill_category_id'
        )->wherePivot('is_primary', 1)
         ->map(fn($cat) => strtoupper(substr($cat->name, 0, 1)))
         ->implode('');
    }

    public function secondarySkill()
    {
        return $this->belongsToMany(
            SkillCategory::class,
            'base_team_player_skill_category',
            'base_team_player_id',
            'skill_category_id'
        )->wherePivot('is_secondary', 1)
         ->map(fn($cat) => strtoupper(substr($cat->name, 0, 1)))
         ->implode('');
    }

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
