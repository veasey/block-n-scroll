<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EventLog extends Model
{
    protected $table = 'event_log';

    public $timestamps = false;

    protected $fillable = [
        'event_type',
        'coach_id',
        'team_id',
        'player_id'
    ];
}
