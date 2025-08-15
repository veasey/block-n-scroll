<?php
namespace App\Repositories;

use App\Models\Base\Skill;
use App\Models\Base\SkillCategory;

class SkillRepository
{
    CONST WALL_THROWER = 41; 
    CONST PORTAL_PASSER = 38;

    protected $dungeonBowlSkills = [
        self::WALL_THROWER,
         self::PORTAL_PASSER,
    ];

     /**
     * Get Random SKill - as per bloodbowl roll for random skill rules
     */
    public function getRandomSkill(int $firstDiceRoll, int $secondDiceRoll, int $skillCategoryID): ?Skill
    {
        $skillCategory = SkillCategory::find($skillCategoryID);
        if (!$skillCategory) return null;

        $skills = $skillCategory->skills->whereNotIn('id', $this->dungeonBowlSkills);

        $skillCount = $skills->count();
        $half = (int) ceil($skillCount / 2);
        $subset = ($firstDiceRoll <= 3) ? $subset = $skills->slice(0, $half)->values() : $subset = $skills->slice($half)->values();

        return $subset->get($secondDiceRoll);
    }
}