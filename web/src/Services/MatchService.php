<?php
namespace App\Services;

use App\Repositories\MatchGameRepository;
use App\Repositories\TeamRepository;

use App\Enums\TeamStatus;
use App\Models\Team;
use App\Models\MatchGame;

class MatchService
{
    public function __construct(
        private MatchGameRepository $matchRepo,
        private TeamRepository $teamRepo
    ) {}

    public function startOrJoinMatch(Team $team, ?int $awayTeamId, ?string $awayTeamName): MatchGame
    {
        $opponent = $this->teamRepo->findTeamByIdOrName($awayTeamId, $awayTeamName);

        $match = $this->matchRepo->getExistingMatch($team, $opponent);

        if ($match) {
            $match->away_team_id = $team->id;
        } else {
            $match = new MatchGame();
            $match->home_team_id = $team->id;
            
            if ($team->league) {
                $match->league_id = $team->league->id;
            }            
            
            if ($opponent) {
                $match->away_team_id = $opponent->id;
            } else {
                $match->away_team_name = $awayTeamName;
            }
        }

        $match->save();

        $team->status = TeamStatus::PLAYING;
        $team->save();

        return $match;
    }
}
