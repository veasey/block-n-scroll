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
use App\Models\Player;

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
            'upgrade_cost' => $this->starPlayerPointHelper->nextSkillCost($player->level)
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
            'player' => $player,
            'skill_categories' => $player->position->primarySkill
        ]);
    }

    public function getSecondarySkillRandomForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/random_secondary_skill.twig', [
            'player' => $player,
            'skill_categories' => $player->position->secondarySkill
        ]);
    }

    private function submitSelectedSkill(Player $player, Skill $skill, int $costIncrease, int $spp, $response) 
    {
        $player->skills()->attach($skill->id);
        $player->cost += $costIncrease;
        $player->spp -= $spp;
        $player->level = $player->getNextLevel();
        $player->save();

        $player->team->current_team_value = $this->teamHelper->calculateCurrentTeamValue($player->team);
        $player->team->save();

        $this->eventLogger->logPlayerLevelUp($player, $skill, '');

        return $this->view->render($response, 'player/spp/add_skill_success.twig', [
            'player' => $player,
            'skill' => $skill
        ]);
    }

    private function handleSubmitSelectSkill(int $goldCost, string $upgradeType, int $skillId, Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        if (!$skill = Skill::find($skillId)) {
            $response->getBody()->write('Skill not found');
            return $response->withStatus(404);
        }

        $sppCost = $this->starPlayerPointHelper->getSppCost($player->level,$upgradeType);
        return $this->submitSelectedSkill($player, $skill, $goldCost, $sppCost, $response);
    }

    public function submitSelectedPrimarySkill(Request $request, Response $response, array $args): Response
    {
        return $this->handleSubmitSelectSkill(
            COST::COST_CHOSEN_PRIMARY_SKILL,
            COST::SELECT_PRIMARY,
            $args['skill_id'],
            $request,
            $response,
            $args
        );
    }

    public function submitSelectedSecondarySkill(Request $request, Response $response, array $args): Response
    {
        return $this->handleSubmitSelectSkill(
            COST::COST_CHOSEN_SECONDARY_SKILL,
            COST::SELECTED_SECONDARY,
            $args['skill_id'],
            $request,
            $response,
            $args
        );
    }

    private function getSkillFromRoll(array $data): mixed {
        
        $categoryId = $data['category_id'];
        $roll1 = (int) $data['primary_random_1'];
        $roll2 = (int) $data['primary_random_2'];

        return $this->skillRepository->getRandomSkill($roll1, $roll2, $categoryId);
    }

    public function submitRandomPrimarySkill(Request $request, Response $response, array $args): Response
    {
        $skill = $this->getSkillFromRoll($request->getParsedBody());

        return $this->handleSubmitSelectSkill(
            COST::COST_RANDOM_PRIMARY_SKILL,
            COST::RANDOM_PRIMARY,
            $skill->id ?? 0,
            $request,
            $response,
            $args
        );
    }

    public function submitRandomSecondarySkill(Request $request, Response $response, array $args): Response
    {
        $skillId = $this->getSkillFromRoll($request->getParsedBody());

        return $this->handleSubmitSelectSkill(
            COST::COST_CHOSEN_SECONDARY_SKILL,
            COST::RANDOM_SECONDARY,
            $skill->id ?? 0,
            $request,
            $response,
            $args
        );
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
