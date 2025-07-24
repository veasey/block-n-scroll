<?php

namespace App\Models\Base;

use Illuminate\Database\Eloquent\Model;

use App\Models\Base\BaseTeamPlayer;
use App\Models\Base\RaceSpecialRule as SpecialRule;
use App\Models\Base\RegionalSpecialRule as RegionalRule;

class SideStaff extends Model
{
    protected $table = 'side_staff';
}
