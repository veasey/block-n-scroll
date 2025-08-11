<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Team;

class MatchGame  extends Model
{
    protected $table = 'player_skill';

    // No updated_at column
    public $timestamps = true;

    // Use acquired_at instead of created_at
    const CREATED_AT = 'acquired_at';
    const UPDATED_AT = null;
}
