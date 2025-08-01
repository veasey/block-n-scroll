<?php
namespace App\Services\EventLogging\Shared;

use App\Models\EventLog;

class EventLoggerService
{
    public static function log(
        string $eventType,
        string $eventValue,
        string $eventKey,
        string $notes,
        $coach = null,
        $team = null,
        $player = null,
        $match = null
    ): void {
        EventLog::create([
            'event_type' => $eventType,
            'event_key' => $eventKey,
            'event_value' => $eventValue ?: null,
            'notes' => $notes,
            'coach_id' => $coach?->id,
            'team_id' => $team?->id,
            'player_id' => $player?->id,
            'match_id' => $match?->id,
        ]);
    }
}
