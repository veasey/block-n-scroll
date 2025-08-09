<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\UserHelper;
use App\Helpers\TeamHelper;
use App\Services\EventLogging\MatchEventLoggingService;
use Slim\Views\Twig;

class NoteController extends AccessController
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

    public function addNote(Request $request, Response $response, array $args): mixed
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $note = $data['note'] ?? '';

        $coach = UserHelper::getCurrentUser();
        $team = TeamHelper::getCurrentPlayingTeam();

        $this->eventLoggerService->addNote($match, $team, $coach, $note);

        return $this->view->render($response, 'match/note.twig', [
            'match' => $match,
            'team' => $team
        ]);
    }
}