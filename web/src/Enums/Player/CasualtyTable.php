<?php
namespace App\Enums\Player;

enum CasualtyTable: string
{
    case BADLY_HURT = 'Badly Hurt';        // 1-6: misses rest of game, no long term effect
    case SERIOUSLY_HURT = 'Seriously Hurt';// 7-9: Miss Next Game (MNG)
    case SERIOUS_INJURY = 'Serious Injury';// 10-12: No Injury (NI) + MNG
    case LASTING_INJURY = 'Lasting Injury';// 13-14: Characteristic Reduction + MNG
    case DEAD = 'Dead';                    // 15-16: Dead, player removed
    
    public static function fromRoll(int $roll): self
    {
        return match (true) {
            $roll >= 1 && $roll <= 6 => self::BADLY_HURT,
            $roll >= 7 && $roll <= 9 => self::SERIOUSLY_HURT,
            $roll >= 10 && $roll <= 12 => self::SERIOUS_INJURY,
            $roll >= 13 && $roll <= 14 => self::LASTING_INJURY,
            $roll >= 15 && $roll <= 16 => self::DEAD,
            default => throw new \InvalidArgumentException("Invalid roll: $roll"),
        };
    }
}