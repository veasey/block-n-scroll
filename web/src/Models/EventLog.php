<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Models\Team;
use App\Models\Player;
use App\Models\MatchGame;

class EventLog extends Model
{
    protected $table = 'event_log';

    public $timestamps = false;

    protected $fillable = [
        'event_type',
        'event_value',
        'event_key',
        'coach_id',
        'team_id',
        'player_id',
        'match_id',
        'notes'
    ];

    public function team(): mixed 
    {
        return $this->belongsTo(Team::class, 'team_id');
    }

    public function player(): mixed 
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    public function matchGame(): mixed 
    {
        return $this->belongsTo(MatchGame::class, 'match_id');
    }
}
