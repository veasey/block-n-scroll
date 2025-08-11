<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Players\Shared\AccessController;
use App\Constants\SPPAward;
use App\Enums\TeamStatus;
use App\Helpers\TeamHelper;
use App\Helpers\MatchHelper;
use App\Repositories\MatchGameRepository;
use App\Services\EventLogging\PlayerEventLoggingService;
use App\Services\Event\InjuryService;
use App\Enums\LogType;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStatus;
use App\Enums\Player\PlayerStats;
use Slim\Views\Twig;

class StarPlayerPointsController extends AccessController
{
    protected $matchHelper;
    protected $teamHelper;
    protected $matchGameRepo;
    protected $eventLogger;
    protected $injuryService;
    protected $view;

    public function __construct(
        MatchHelper $matchHelper,
        TeamHelper $teamHelper,
        MatchGameRepository $matchGameRepo,
        PlayerEventLoggingService $eventLogger, 
        InjuryService $injuryService,
        Twig $view
    )
    {
        $this->teamHelper = $teamHelper;
        $this->matchHelper = $matchHelper;
        $this->matchGameRepo = $matchGameRepo;
        $this->eventLogger = $eventLogger;
        $this->injuryService = $injuryService;
        $this->view = $view;
    }
    
    public function getStarPlayerPointsForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'player/spp/form.twig', [
            'primarySkills' => []
            'secondarySkills' => []
        ]);
    }
}
