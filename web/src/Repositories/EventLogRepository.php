<?php
namespace App\Repositories;

use Illuminate\Support\Collection;

use App\Models\EventLog;
use App\Models\MatchGame;

class EventLogRepository
{
    public function getMatchEventLogs(MatchGame $match): Collection
    {
        return EventLog::where('match_id', $match->id)->get();
    }
}