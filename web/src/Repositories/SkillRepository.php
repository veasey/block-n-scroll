<?php
namespace App\Repositories;

use Illuminate\Support\Collection;

use App\Models\Base\Skill;
use App\Models\Player;

class SkillRepository
{
    CONST WALL_THROWER = 41; 
    CONST PORTAL_PASSER = 38;

    protected $dungeonBowlSkills = [
        self::WALL_THROWER,
         self::PORTAL_PASSER,
    ];

    private function getAvailableSkillsInCategories(Collection $categories)
    {   
        return Skill::whereIn('category', $categories)
                    ->whereNotIn('id', $this->dungeonBowlSkills)
                    ->get();
    }

    public function getAvailableSkills(Player $player): array
    {
        
        $primarySkillCategory = $player->position->primarySkill->pluck('name');
        $secondarySkillCategory = $player->position->secondarySkill->pluck('name');

        return [
            'primary' => $this->getAvailableSkillsInCategories($primarySkillCategory),
            'secondary' => $this->getAvailableSkillsInCategories($secondarySkillCategory),
        ];
    }
}