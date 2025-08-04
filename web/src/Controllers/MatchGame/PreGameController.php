<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use InvalidArgumentException;

use Slim\Views\Twig;

use App\Enums\Match\WeatherTable;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\TeamHelper;
use App\Repositories\EventLogRepository;
use App\Repositories\TeamRepository;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\MatchService;

class PreGameController extends AccessController
{
    protected $logRepo;
    protected $teamRepo;
    protected $eventLoggerService;
    protected $matchService;
    protected $view;

    public function __construct(
        EventLogRepository $logRepo,
        TeamRepository $teamRepo,
        MatchEventLoggingService $eventLoggerService,
        MatchService $matchService,
        Twig $view
    )    
    {
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

        return $this->view->render($response, 'match/start/start_match.twig', [
            'team' => $team, 
            'eligibleTeams' => $this->teamRepo->getEligableTeams($team)
        ]);
    }

    public function startMatch(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $awayTeamId = (int) $data['opponent_team_id'];
        $awayTeamName = $data['unregistered_name'] ?? '';

        $match = $this->matchService->startOrJoinMatch($team, $awayTeamId, $awayTeamName);
        $this->eventLoggerService->logMatchStart($match);

        // Redirect to weather form
        return $response
        ->withHeader('Location', "/match/{$match->id}/gate")
        ->withStatus(302);
    }

    public function showGateForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        return $this->view->render($response, 'match/start/gate.twig', ['match' => $match]);
    }

    public function submitGate(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();
        $homeFanRoll = $data['home_fan_roll'] ?? 1;
        $awayFanRoll = $data['away_fan_roll'] ?? 1;
        $awayDedicatedFans = $data['away_dedicated_fans'] ?? 1;

        $match->home_fans = $homeFanRoll;
        $match->away_fans = $awayFanRoll;
        $match->save();

        $this->eventLoggerService->logMatchFanAttendance($match, $awayDedicatedFans);

        // Redirect to weather form
        $url = "/match/{$match->id}/weather"; // adjust as needed
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }

    public function showWeatherForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        return $this->view->render($response, 'match/start/weather.twig', ['match' => $match]);
    }

    public function submitWeather(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();
        $weatherRoll = (int)($data['weather_roll'] ?? 2);

        try {
            $weather = WeatherTable::fromRoll($weatherRoll);
        } catch (InvalidArgumentException $e) {
            // Handle invalid roll (e.g., redirect back with error)
            return $response->withStatus(400)->write("Invalid weather roll: $weatherRoll");
        }

        // Log the weather (you can store the enum name or value)
        $this->eventLoggerService->logMatchWeather($match, $weather);

        // Redirect to next step
        $url = "/match/{$match->id}/kickoff";
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }

    public function kickoff(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $this->eventLoggerService->logKickOff($match);
        $team = TeamHelper::getCurrentPlayingTeam();

        $matchInfo = $this->matchService->getMatchSetupInfo($match);

        return $this->view->render($response, 'match/start/kickoff.twig', [
            'match' => $match,
            'user_team_id' => $team->id,
            'match_info' => $matchInfo
        ]);
    }
}