<?php
namespace App\Services;

use App\Models\EventLog;

class EventLogger
{
    public static function log(
        string $eventType,
        array $eventValue = [],
        string $eventKey = null,
        string $notes = null,
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
