<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Players\Shared\AccessController;
use App\Helpers\StarPlayerPointHelper;
use App\Helpers\UserHelper;
use App\Repositories\SkillRepository;
use App\Services\EventLogging\PlayerEventLoggingService;
use Slim\Views\Twig;

class StarPlayerPointsController extends AccessController
{
    protected $starPlayerPointHelper;
    protected $eventLogger;
    protected $skillRepository;
    protected $view;

    public function __construct(
        StarPlayerPointHelper $starPlayerPointHelper,
        UserHelper $userHelper,
        PlayerEventLoggingService $eventLogger, 
        SkillRepository $skillRepository,
        Twig $view,
    )
    {
        parent::__construct($userHelper);
        $this->starPlayerPointHelper = $starPlayerPointHelper;
        $this->eventLogger = $eventLogger;
        $this->skillRepository = $skillRepository;
        $this->view = $view;
    }
    
    public function getStarPlayerPointsForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        $skills = $this->skillRepository->getAvailableSkills($player);

        return $this->view->render($response, 'player/spp/form.twig', [
            'player' => $player,
            'skills' => $skills,
            'updgradeCost' => $this->starPlayerPointHelper->nextSkillCost()
        ]);
    }
}
