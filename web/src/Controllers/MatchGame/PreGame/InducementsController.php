<?php
namespace App\Controllers\MatchGame\PreGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Enums\Match\PreGameStatus;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\TeamHelper;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\MatchService;

class InducementsController extends AccessController
{
    protected $eventLoggerService;
    protected $teamHelper;
    protected $matchService;
    protected $view;

    public function __construct(
        MatchEventLoggingService $eventLoggerService,
        TeamHelper $teamHelper,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->eventLoggerService = $eventLoggerService;
        $this->teamHelper = $teamHelper;
        $this->matchService = $matchService;
        $this->view = $view;
    }

    public function showInducementsForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $team = $this->teamHelper->getCurrentPlayingTeam();
        $inducementBudget = $this->matchService->calculateInducementBudget($match, $team);

        return $this->view->render($response, 'match/start/6_inducements.twig', [
            'match' => $match, 
            'inducement_budget' => $inducementBudget, 
            'team' => $team]
        );
    }

    public function submitInducements(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        // For now, we are not processing inducement purchases.
        // In a real application, you would handle the inducement logic here.

        $match->pregame_status = PreGameStatus::KICKOFF;
        $match->save();

        // Redirect to kickoff
        $url = "/match/{$match->id}/kickoff";
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }
}