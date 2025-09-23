<?php
namespace App\Controllers\MatchGame\PreGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Enums\Match\PreGameStatus;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\TeamHelper;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\PlayerService;
use App\Services\MatchService;

class JourneymenController extends AccessController
{
    protected $teamHelper;
    protected $eventLoggerService;
    protected $playerService;
    protected $matchService;
    protected $view;

    public function __construct(
        TeamHelper $teamHelper,
        MatchEventLoggingService $eventLoggerService,
        PlayerService $playerService,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->teamHelper = $teamHelper;
        $this->eventLoggerService = $eventLoggerService;
        $this->playerService = $playerService;
        $this->matchService = $matchService;
        $this->view = $view;
    }

    public function showJourneymenForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        // check any team is short of players
        if (!$this->matchService->isEitherTeamShortOfPlayers($match)) {

            // update match status
            $match->pregame_status = PreGameStatus::INDUCEMENTS;
            $match->save();

            // Redirect to inducements form
            $url = "/match/{$match->id}/inducements";
            return $response
                ->withHeader('Location', $url)
                ->withStatus(302);
        }

        $team = $this->teamHelper->getCurrentPlayingTeam();
        $howManyJourneymenNeeded = $this->matchService->howManyJourneymenNeeded($team);
        return $this->view->render($response, 'match/start/5_journeymen.twig', [
            'match' => $match,
            'how_many_journeymen_needed' => $howManyJourneymenNeeded,
            'team' => $team
        ]);
    }

    public function submitJourneymen(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        foreach ([$match->homeTeam, $match->awayTeam] as $team) {
            if ($team) {
                $amount = $this->matchService->howManyJourneymenNeeded($team);
                if ($amount > 0) {
                    $this->playerService->generateJourneymen($team, $amount);
                }
            }
        }

        $match->pregame_status = PreGameStatus::INDUCEMENTS;
        $match->save();

        // Redirect to inducements form
        $url = "/match/{$match->id}/inducements";
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }
}