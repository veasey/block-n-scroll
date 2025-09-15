<?php

namespace App\Enums\Player;

enum Level: string
{
    case JOURNEYMAN    = 'Journeyman';
    case ROOKIE        = 'Rookie';
    case EXPERIENCED   = 'Experienced';
    case VETERAN       = 'Veteran';
    case EMERGINGSTAR  = 'Emerging Star';
    case STAR          = 'Star';
    case SUPERSTAR     = 'Superstar';
    case LEGEND        = 'Legend';

    public static function ordered(): array
    {
        return [
            self::Journeyman,
            self::Rookie,
            self::Experienced,
            self::Veteran,
            self::EmergingStar,
            self::Star,
            self::Superstar,
            self::Legend,
        ];
    }

    public function next(): ?self
    {
        $order = self::ordered();
        $index = array_search($this, $order, true);

        return ($index !== false && isset($order[$index + 1]))
            ? $order[$index + 1]
            : null;
    }

    public static function default(): self
    {
        return self::ROOKIE;
    }
}
