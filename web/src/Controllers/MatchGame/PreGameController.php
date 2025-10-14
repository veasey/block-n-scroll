<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Enums\Match\PreGameStatus;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\TeamHelper;
use App\Helpers\MatchHelper;
use App\Repositories\EventLogRepository;
use App\Repositories\TeamRepository;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\MatchService;

use Slim\Views\Twig;

class PreGameController extends AccessController
{
    protected $logRepo;
    protected $matchHelper;
    protected $teamHelper;
    protected $teamRepo;
    protected $eventLoggerService;
    protected $matchService;
    protected $view;

    public function __construct(
        MatchHelper $matchHelper,
        TeamHelper $teamHelper,
        EventLogRepository $logRepo,
        TeamRepository $teamRepo,
        MatchEventLoggingService $eventLoggerService,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->teamHelper = $teamHelper;
        $this->matchHelper = $matchHelper;
        $this->logRepo = $logRepo;
        $this->teamRepo = $teamRepo;
        $this->eventLoggerService = $eventLoggerService;
        $this->matchService = $matchService;
        $this->view = $view;
    }

    public function showStartMatchForm(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'match/start/1_start_match.twig', [
            'team' => $team, 
            'eligibleTeams' => $this->teamRepo->getEligableTeams($team)
        ]);
    }

    public function createMatch(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $awayTeamId = (int) $data['opponent_team_id'];
        $awayTeamName = $data['unregistered_name'] ?? '';

        // has opponent already started the match?
        if ($match = $this->matchHelper->getCurrentMatchTeamPlayingIn($team)) {
            return $this->view->render($response, 'match/start/2_duplicate_start_match.twig', ['match' => $match, 'team' => $team]);
        }

        if (!$awayTeamId && empty($awayTeamName)) {
            $response->getBody()->write("A team cannot play with itself.");
            return $response->withStatus(404);
        }

        $match = $this->matchService->startOrJoinMatch($team, $awayTeamId, $awayTeamName);
        $this->eventLoggerService->logMatchStart($match);

        // Redirect to weather form
        return $response
        ->withHeader('Location', "/match/{$match->id}/gate")
        ->withStatus(302);
    }

    public function kickoff(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        // log kickoff event
        $this->eventLoggerService->logKickOff($match);
        $this->matchService->kickOff($match);
    
        $matchInfo = $this->matchService->getMatchSetupInfo($match);
        $team = $this->teamHelper->getCurrentPlayingTeam();

        return $this->view->render($response, 'match/start/7_kickoff.twig', [
            'match' => $match,
            'user_team_id' => $team->id,
            'match_info' => $matchInfo
        ]);
    }

    public function continuePregameSetup(Request $request, Response $response, array $args)
    {
        $currentPlayingTeam = $this->teamHelper->getCurrentPlayingTeam();
        if (!$currentPlayingTeam) {
            $response->getBody()->write("You do not have a team in pregame status.");
            return $response->withStatus(403);
        }

        $match = $this->matchHelper->getCurrentMatchTeamPlayingIn($currentPlayingTeam);
        if (!$match) {
            $response->getBody()->write("No match found for your team.");
            return $response->withStatus(404);
        }

        // determine next step
        switch (PreGameStatus::tryFrom($match->pregame_status)) {
            case PreGameStatus::FANS:
                $url = "/match/{$match->id}/gate";
                break;
            case PreGameStatus::WEATHER:
                $url = "/match/{$match->id}/weather";
                break;
            case PreGameStatus::JOURNEYMEN:
                $url = "/match/{$match->id}/journeymen";
                break;
            case PreGameStatus::INDUCEMENTS:
                $url = "/match/{$match->id}/inducements";
                break;
            case PreGameStatus::KICKOFF:
                $url = "/match/{$match->id}/kickoff";
                break;
            default:
                // something went wrong
                $response->getBody()->write("Match in invalid pregame status.");
                return $response->withStatus(500);
        }
        
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }
}