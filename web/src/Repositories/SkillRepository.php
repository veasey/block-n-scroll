<?php
namespace App\Repositories;

use Illuminate\Support\Collection;

use App\Models\Base\Skill;
use App\Models\Base\SkillCategory;

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

    public function getPrimarySkills(Player $player): Collection
    {
        $primarySkillCategory = $player->position->primarySkill->pluck('name');
        return $this->getAvailableSkillsInCategories($primarySkillCategory);
    }

    public function getSecondarySkills(Player $player): Collection
    {
        $primarySkillCategory = $player->position->secondarySkill->pluck('name');
        return $this->getAvailableSkillsInCategories($primarySkillCategory);
    }

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