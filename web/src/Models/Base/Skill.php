<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\SkillCategory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Skill extends Model
{
    protected $table = 'skill';

    public function skillCategory(): BelongsTo
    {
        return $this->belongsTo(SkillCategory::class, 'category_id');
    }
}
