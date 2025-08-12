<?php

namespace App\Enums\Player;

enum Level: string
{
    case Journeyman    = 'Journeyman';
    case Rookie        = 'Rookie';
    case Experienced   = 'Experienced';
    case Veteran       = 'Veteran';
    case EmergingStar  = 'Emerging Star';
    case Star          = 'Star';
    case Superstar     = 'Superstar';
    case Legend        = 'Legend';

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
}
