<?php
namespace App\Enums\Match;

enum EventType: string
{
    case  INJURY = 'injury';
    case  CASUALTY = 'casualty';
    case  TOUCHDOWN = 'touchdown';
    case  COMPLETION = 'completion';
    case FAN_ATTENDANCE = 'fan_attendance';
    case WINNINGS = 'winnings';
    case WEATHER = 'weather';
    case KICK_OFF = 'kick_off';
}
