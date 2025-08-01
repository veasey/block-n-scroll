<?php

namespace App\Enums\Match;

enum WeatherTable: string
{
    case SWELTERING_HEAT = 'Sweltering Heat';
    case VERY_SUNNY = 'Very Sunny';
    case NICE = 'Nice';
    case POURING_RAIN = 'Pouring Rain';
    case BLIZZARD = 'Blizzard';

    public static function fromRoll(int $roll): self
    {
        return match (true) {
            $roll <= 2 => self::SWELTERING_HEAT,
            $roll === 3 => self::VERY_SUNNY,
            $roll >= 4 && $roll <= 10 => self::NICE,
            $roll === 11 => self::POURING_RAIN,
            $roll >= 12 => self::BLIZZARD,
            default => throw new InvalidArgumentException("Invalid weather roll: $roll"),
        };
    }
}