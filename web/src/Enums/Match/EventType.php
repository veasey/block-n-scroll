<?php
namespace App\Enums\Match;

enum EventType: string
{
    case  INJURY = 'injury';
    case  CASUALTY = 'casualty';
    case  TOUCHDOWN = 'touchdown';
    case  COMPLETION = 'completion';
    case FAN_ATTENDANCE = 'fan_attendance';
    case UPDATE_POPULARITY = 'update_popularity';
    case WINNINGS = 'winnings';
    case WEATHER = 'weather';
    case KICK_OFF = 'kick_off';
}
