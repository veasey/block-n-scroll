<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use App\Models\Base\BaseTeam;
use App\Models\Base\SkillCategory;

class BaseTeamPlayer extends Model
{
    protected $table = 'base_team_player';
    protected $fillable = [
        'base_team_player_id'
    ];

    public function primarySkill(): BelongsToMany
    {
        return $this->belongsToMany(
            SkillCategory::class,
            'base_team_player_skill_category'
        )->wherePivot('is_primary', 1);
    }

    public function getPrimarySkills()
    {
        return $this->formatSkillCategories($this->primarySkill);
    }

    public function secondarySkill()
    {
        return $this->belongsToMany(
            SkillCategory::class,
            'base_team_player_skill_category'
        )->wherePivot('is_secondary', 1);
    }

    public function getSecondarySkills()
    {
        return $this->formatSkillCategories($this->secondarySkill);
    }

    private function formatSkillCategories(Collection $categories): string
    {
        return $categories
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

    public function race(): mixed
    {
        return $this->belongsTo(BaseTeam::class, 'base_team_id');
    }
}
