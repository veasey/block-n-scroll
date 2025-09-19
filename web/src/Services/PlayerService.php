<?php
namespace App\Services;

use App\Enums\Player\Level;
use App\Helpers\PlayerFilterHelper;
use App\Helpers\UserHelper;
use App\Models\Base\BaseTeamPlayer;
use App\Models\DefaultPlayerName;
use App\Models\Team;
use App\Models\Player;

class PlayerService
{
    protected $userHelper;
    protected $playerFilterHelper;

    public function __construct(
        UserHelper $userHelper,
        PlayerFilterHelper $playerFilterHelper
    ) {
        $this->userHelper = $userHelper;
        $this->playerFilterHelper = $playerFilterHelper;
    }

    public function generateTeamPlayer(Team $team, BaseTeamPlayer $baseTeamPlayer, int $number): Player
    {
        $player = new Player();
        $player->team_id = (int) $team->id;
        $player->base_team_id = (int) $baseTeamPlayer->base_team_id;
        $player->base_team_player_id = (int) $baseTeamPlayer->id;
        $player->cost = (int) $baseTeamPlayer->cost;

        $player->number = $number;

        // fill in default names
        $player->name = DefaultPlayerName::getRandomFor($baseTeamPlayer->base_team_id, $baseTeamPlayer->name);

        $player->ma = (int) $baseTeamPlayer->ma;
        $player->st = (int) $baseTeamPlayer->st;
        $player->ag = (int) $baseTeamPlayer->ag;
        $player->av = (int) $baseTeamPlayer->av;
        $player->pa = (int) $baseTeamPlayer->pa;

        $player->original_coach_id = (int) $this->userHelper->getCurrentUser()->id ?? 0;

        return $player;
    }

    public function generateJourneymen(Team $team, int $amount): void
    {
        $linemanBasePlayer = BaseTeamPlayer::where('base_team_id', $team->base_team_id)
            ->where('name', 'Lineman')
            ->first();

        foreach(range(1, $amount) as $i) {
            $this->generateSingleJourneyman($team, $linemanBasePlayer);
        }
    }

    private function generateSingleJourneyman(Team $team, BaseTeamPlayer $linemanBasePlayer): Player
    {
        $playerNumber = 1;
        $availablePlayers = $this->playerFilterHelper->notIndisposed($team->players)->sortBy('number')->values();       

        foreach($availablePlayers as $existingPlayer) {
            if ($existingPlayer->number != $playerNumber) {
                break;
            }
            $playerNumber++;
        }

        $player = $this->generateTeamPlayer($team, $linemanBasePlayer, $playerNumber);
        $player->level = Level::JOURNEYMAN;
        $player->save();

        $team->players->push($player);
        $team->save();

        return $player;
    }      
}
