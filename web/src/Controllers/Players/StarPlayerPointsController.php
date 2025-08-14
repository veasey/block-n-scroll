<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Players\Shared\AccessController;
use App\Helpers\StarPlayerPointHelper;
use App\Helpers\UserHelper;

use Slim\Views\Twig;

class StarPlayerPointsController extends AccessController
{
    protected $starPlayerPointHelper;
    protected $view;

    public function __construct(
        UserHelper $userHelper,
        StarPlayerPointHelper $starPlayerPointHelper,
        Twig $view,
    )
    {
        parent::__construct($userHelper);
        $this->starPlayerPointHelper = $starPlayerPointHelper;
        $this->view = $view;
    }
    
    public function getStarPlayerPointsForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/form.twig', [
            'player' => $player,
            'upgrade_cost' => $this->starPlayerPointHelper->nextSkillCost($player->level)
        ]);
    }
}
