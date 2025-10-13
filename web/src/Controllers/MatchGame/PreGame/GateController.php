<?php
namespace App\Controllers\MatchGame\PreGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Enums\Match\PreGameStatus;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Services\EventLogging\MatchEventLoggingService;

use Slim\Views\Twig;

class GateController extends AccessController
{
    protected $eventLoggerService;
    protected $view;

    public function __construct(
        MatchEventLoggingService $eventLoggerService,
        Twig $view
    )    
    {
        $this->eventLoggerService = $eventLoggerService;
        $this->view = $view;
    }

    public function showForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        return $this->view->render($response, 'match/start/3_gate.twig', ['match' => $match]);
    }

    public function submit(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();
        $homeFanRoll = $data['home_fan_roll'] ?? 1;
        $awayFanRoll = $data['away_fan_roll'] ?? 1;
        $awayDedicatedFans = $data['away_dedicated_fans'] ?? 1;

        $match->home_fans = $homeFanRoll;
        $match->away_fans = $awayFanRoll;
        $match->pregame_status = PreGameStatus::WEATHER;
        $match->save();

        $this->eventLoggerService->logMatchFanAttendance($match, $awayDedicatedFans);

        // Redirect to weather form
        $url = "/match/{$match->id}/weather"; // adjust as needed
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }
}