<?php
namespace App\Enums\Player;

enum PlayerLevel: string
{
    case JOURNEYMAN = 'Journeyman';
    case ROOKIE = 'Rookie';
    case EXPERIENCED = 'Experienced';
    case VETERAN = 'Veteran';
    case EMERGING_STAR = 'Emerging Star';
    case STAR = 'Star';
    case SUPERSTAR = 'Superstar';
    case LEGEND = 'Legend';

    // Optional: default value helper
    public static function default(): self
    {
        return self::ROOKIE;
    }
}
