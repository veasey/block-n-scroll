<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

class SkillRandomSelection extends Model
{
    protected $table = 'skill_random_selection';
    public $timestamps = false;

    protected $fillable = [
        'first_d6',
        'second_d6',
        'agility_skill',
        'general_skill',
        'mutations_skill',
        'passing_skill',
        'strength_skill',
    ];
}



