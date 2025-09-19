<?php
namespace App\Enums\Match;

enum PregameStatus: string
{
    // rolling for fan attendnace
    case  FANS = 'fans';

    // roll for starting weather
    case  WEATHER = 'weather';

    // take on journeymen, if unable to field 11 players
    case  JOURNEYMEN = 'journeymen';

    // buy inducements
    case  INDUCEMENTS = 'inducements';

    case KICKOFF = 'kickoff';
}
