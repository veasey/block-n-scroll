<?php
namespace App\Controllers\Players;

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

use Slim\Views\Twig;

class StarPlayerPointsController extends AccessController
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
    
    public function getStarPlayerPointsForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/form.twig', [
            'player' => $player,
            'upgrade_cost' => $this->starPlayerPointHelper->nextSkillCost($player)
        ]);
    }

    public function getPrimarySkillSelectForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/select_primary_skill.twig', [
            'player' => $player,
            'skills' => $this->skillRepository->getPrimarySkills($player)
        ]);
    }

    public function getPrimarySkillRandomForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/random_primary_skill.twig', [
            'player' => $player
        ]);
    }

    private function submitSelectedSkill(Player $player, Skill $skill, int $costIncrease) {
        
        $player->skills()->attach($skill->Id);
        $player->cost += $costIncrease;
        $player->save();

        $player->team->current_team_value = $this->teamHelper->calculateCurrentTeamValue($player->team);
        $player->team->save();

        return $this->view->render($response, 'player/spp/add_skill_success.twig', [
            'player' => $player,
            'skill' => $skill
        ]);
    }

    public function submitSelectedPrimarySkill(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        if (!$skill = Skill::find($args['skill_id'])) {
            $response->getBody()->write('Skill not found');
            return $response->withStatus(404);
        }      

        return $this->submitSelectedSkill($player, $skill, COST::COST_CHOSEN_PRIMARY_SKILL);
    }

    public function submitSelectedSecondarySkill(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        if (!$skill = Skill::find($args['skill_id'])) {
            $response->getBody()->write('Skill not found');
            return $response->withStatus(404);
        }      

        return $this->submitSelectedSkill($player, $skill, COST::COST_CHOSEN_SECONDARY_SKILL);
    }
}
