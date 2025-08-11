<?php
namespace App\Constants\SPP;

class Cost
{
    public const UPDGRADE_THRESHOLD = [
        'Rookie'   => [
            'random_primary'   => 3,
            'select_primary_or_random_secondary' => 6,
            'select_secondary' => 12,
            'characteristic' => 18,
        ],
        'Experienced'       => [
            'random_primary'   => 4,
            'select_primary_or_random_secondary' => 8,
            'selected_secondary' => 14,
            'characteristic' => 20,
        ],
        'Veteran' => [
            'random_primary'   => 6,
            'select_primary_or_random_secondary' => 10,
            'selected_secondary' => 16,
            'characteristic' => 24,
        ],
        'Emerging Star'          => [
            'random_primary'   => 8,
            'select_primary_or_random_secondary' => 12,
            'selected_secondary' => 18,
            'characteristic' => 28,
        ],
        'Star'    => [
            'random_primary'   => 10,
            'select_primary_or_random_secondary' => 14,
            'selected_secondary' => 20,
            'characteristic' => 32,
        ],
        'Super Star'        => [
            'random_primary'   => 15,
            'select_primary_or_random_secondary' => 30,
            'selected_secondary' => 40,
            'characteristic' => 50,
        ],
    ];

    const COST_RANDOM_PRIMARY_SKILL = 10000;
    const COST_CHOSEN_PRIMARY_SKILL = 20000;
    const COST_RANDOM_SECONDARY_SKILL = 20000;
    const COST_CHOSEN_SECONDARY_SKILL = 40000;

    const COST_AV = 10000;
    const COST_MA = 20000;
    const COST_AG = 40000;
    const COST_ST = 80000;
}