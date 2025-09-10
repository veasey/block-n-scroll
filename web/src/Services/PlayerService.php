<?php
namespace App\Services;

use App\Enums\LogType;
use App\Enums\Match\EventType;
use Illuminate\Database\Eloquent\Collection;

use App\Repositories\MatchGameRepository;
use App\Repositories\TeamRepository;

use App\Enums\TeamStatus;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStatus;
use App\Models\EventLog;
use App\Models\Team;
use App\Models\Player;

class PlayerService
{
    public function generateTeamPlayer(Team $team, BaseTeamPlayer $baseTeamPlayer, int $number): void
    {
        $player = new Player();
        $player->team_id = (int) $team->id;
        $player->base_team_id = (int) $baseTeamPlayer->base_team_id;
        $player->base_team_player_id = (int) $positionId;
        $player->cost = (int) $baseTeamPlayer->cost;

        $player->number = $nextNumber;

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

    public function generateJourneyman(Team $team): Player
    {
        $linemanBasePlayer = BaseTeamPlayer::where('base_team_id', $team->base_team_id)
            ->where('name', 'Lineman')
            ->first();

        $playerNumber = 1;
        foreach($team->players as $existingPlayer) {
            if ($existingPlayer->number == $playerNumber) {
                $playerNumber++;
            } else {
                break; // Found a gap
            }
        }

        $player = $this->generateTeamPlayer($team, $linemanBasePlayer, $playerNumber);
        $player->status = PlayerStatus::JOURNEYMAN->value;
        return $player;
    }    
}
