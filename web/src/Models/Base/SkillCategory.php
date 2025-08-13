<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

use App\Models\Base\Skill;

class SkillCategory extends Model
{
    protected $table = 'skill_category';

    public function skills(): HasMany
    {
        return $this->hasMany(Skill::class, 'category_id');
    }
}
