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

class CharacteristicsController extends AccessController
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

    public function submitRoll(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();     
        $improvementRoll = (int) $data['improvement_roll'];
        $characteristic = [];
        $secondarySkills = $this->skillRepository->getSecondarySkills($player);

        // 1‑7 Improve either MA or AV by 1 (or choose a Secondary skill).
        if ($improvementRoll >= 1 || $improvementRoll <= 7) {
            $characteristic = ['MA', 'AV'];
        }

        // 8‑13 Improve either MA, PA, or AV by 1 (or choose a Secondary skill).
        if ($improvementRoll >= 8 || $improvementRoll <= 13) {
            $characteristic = ['MA', 'PA', 'AV'];
        }

        // 14 Improve either AG or PA by 1 (or choose a Secondary skill).
        if ($improvementRoll >= 8 || $improvementRoll <= 13) {
            $characteristic = ['AG', 'PA'];
        }

        // 15 Improve either ST or AG by 1 (or choose a Secondary skill).
        if ($improvementRoll == 15) {
            $characteristic = ['ST', 'AG'];
        }

        // 16 Improve a characteristic of your choice by 1.
        if ($improvementRoll == 16) {
            $characteristic = ['MA', 'AV', 'PA', 'ST', 'AG'];
            $secondarySkills = false;
        }

        return $this->view->render($response, 'player/spp/characteristic/choose_characteristic.twig', [
            'player' => $player,
            'characteristic' => $characteristic,
            'secondarySkills' => $secondarySkills
        ]);
    }
}
