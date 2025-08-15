<?php
namespace App\Controllers\Players\StarPlayerPoints;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Constants\SPP\Cost;
use App\Controllers\Players\Shared\AccessController;
use App\Helpers\StarPlayerPointHelper;
use App\Helpers\UserHelper;
use App\Repositories\SkillRepository;
use App\Services\EventLogging\PlayerEventLoggingService;

use Slim\Views\Twig;

class CharacteristicsController extends AccessController
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
    
    public function getRollD16Form(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
   
        return $this->view->render($response, 'player/spp/characteristic/rolld16.twig', [
            'player' => $player,
            'skill_categories' => $player->position->secondarySkill
        ]);
    }

    public function getCharacteristicForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();     
        $improvementRoll = (int) $data['improvement_roll'];
        
        $secondarySkills = null;
        $characteristic = $this->starPlayerPointHelper->getRandomCharacteristicsStatFromRoll($improvementRoll, $player);

        if ($improvementRoll == 16) {            
            $secondarySkills = false;
        } else {
            $secondarySkills = $player->position->secondarySkill
                ->flatMap(fn($category) => $category->skills)
                ->unique('id')
                ->values();
        }

        return $this->view->render($response, 'player/spp/characteristic/choose_characteristic.twig', [
            'player' => $player,
            'characteristics' => $characteristic,
            'secondarySkills' => $secondarySkills
        ]);
    }

    public function getSelectCharacteristicResult(Request $request, Response $response, array $args): Response
    {
        // increase characteristic
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();     
        $stat = $data['characteristic'];
        $col = strtolower($stat);
        $increased = true;

        if (in_array($stat, ['MA', 'AV', 'ST'])) {
            $player->$col += 1;
        }

        else if (in_array($stat, ['PA', 'AG'])) {
            $player->$col -= 1;
            $increased = false;
        }

        $this->eventLogger->logPlayerLevelUp($player, null, $stat);
        $player->spp -= $this->starPlayerPointHelper->getSppCost($player->level, Cost::CHARACTERISTIC);
        $player->cost += $this->starPlayerPointHelper->getGoldCostForCharacteristic($stat);
        $player->save();

        return $this->view->render($response, 'player/spp/characteristic/success.twig', [
            'player' => $player,
            'stat' => $stat,
            'is_increased' => $increased
        ]);
    }
}
