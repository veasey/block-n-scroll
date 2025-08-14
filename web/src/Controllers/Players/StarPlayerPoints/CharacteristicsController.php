<?php
namespace App\Controllers\Players\StarPlayerPoints;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Constants\SPP\Cost;
use App\Controllers\Players\Shared\AccessController;
use App\Helpers\StarPlayerPointHelper;
use App\Helpers\TeamHelper;
use App\Helpers\UserHelper;
use App\Repositories\SkillRepository;
use App\Services\EventLogging\PlayerEventLoggingService;
use App\Models\Base\Skill;
use App\Models\Player;

use Slim\Views\Twig;

class SkillsController extends AccessController
{
    protected $starPlayerPointHelper;
    protected $teamHelper;
    protected $eventLogger;
    protected $skillRepository;
    protected $view;

    public function __construct(
        StarPlayerPointHelper $starPlayerPointHelper,
        TeamHelper $teamHelper,
        UserHelper $userHelper,
        PlayerEventLoggingService $eventLogger, 
        SkillRepository $skillRepository,
        Twig $view,
    )
    {
        parent::__construct($userHelper);
        $this->teamHelper = $teamHelper;
        $this->starPlayerPointHelper = $starPlayerPointHelper;
        $this->eventLogger = $eventLogger;
        $this->skillRepository = $skillRepository;
        $this->view = $view;
    }
    
    public function getCharacteristicForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/characteristic/rolld16.twig', [
            'player' => $player,
            'skill_categories' => $player->position->secondarySkill
        ]);
    }
}
