<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Players\Shared\AccessController;
use App\Helpers\UserHelper;
use App\Models\Player;
use App\Services\EventLogging\PlayerEventLoggingService as EventLogger;

use Slim\Views\Twig;

class EditController extends AccessController
{
    protected $eventLogger;
    protected $view;

    public function __construct(EventLogger $eventLogger, UserHelper $userHelper, Twig $view)
    {
        parent::__construct($userHelper);
        $this->eventLogger = $eventLogger;
        $this->view = $view;
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        return $this->view->render($response, 'player/edit/form.twig', ['player' => $player]);
    }

    private function showValidationFailure(string $message, Player $player, Response $response): Response
    {
        return $this->view->render($response, 'player/edit/validation_fail.twig', [
            'player' => $player, 
            'error' => $message
        ]);
    }

    public function save(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $playerChanged = false;
        $data = $request->getParsedBody();
        $newName = $data['name'];
        $newNumber = (int) $data['number'];

        if ($player->name != $newName) {

            // validate format
            if (mb_strlen(trim($newName)) === 0) {
                return $this->showValidationFailure('Invalid Name', $player, $response);
            }

            // check not duplicate
            $exists = Player::where('team_id', $player->team->id)
                ->where('name', $newName)
                ->where('id', '<>', $player->id)
                ->exists();

            if ($exists) {
                return $this->showValidationFailure('Name already exists on team', $player, $response);
            }

            $player->name = $newName;
            $playerChanged = true;
        }

        if ($player->number != $newNumber) {

            // if number is another player, swap them.
            $playerWithNumberAlready = Player::where('number', $newNumber)
                ->where('team_id', $player->team_id)
                ->first();

            if ($playerWithNumberAlready) {
                $playerWithNumberAlready->number = $player->number;
                $playerWithNumberAlready->save();
            }

            $player->number = $newNumber;
            $playerChanged = true;
        }

        if ($playerChanged) {
            $this->eventLogger->logPlayerInfoUpdate($player, $newName, $newNumber);
            $player->save();
        }

        return $this->view->render($response, 'player/edit/success.twig', ['player' => $player]);
    }
}
