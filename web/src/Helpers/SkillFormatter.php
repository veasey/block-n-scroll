<?php
namespace App\Helpers;

use Illuminate\Support\Collection;

class SkillFormatter
{
    /**
     * Format Skill Category Initials
     * This is to get Primary Skills and Secondary Skills and return them as Captital Letters 
     * @param Collection $categories
     * @return string
     * */
    public static function formatSkillCategoryInitials(Collection $categories): string
    {
        return $categories
            ->map(fn($cat) => strtoupper(substr($cat->name, 0, 1)))
            ->implode('');
    }
}
