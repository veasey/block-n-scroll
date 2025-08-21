<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Leagues\Shared\AccessController;
use App\Helpers\UserHelper;
use App\Models\League;

use Slim\Views\Twig;

class CreateController extends AccessController
{
    protected $view;

    public function __construct(
        UserHelper $userHelper,
        Twig $view
    )
    {
        $this->userHelper = $userHelper;
        $this->view = $view;
    }

    public function getEditForm(Request $request, Response $response, array $args): Response
    {        
        return $this->view->render($response, 'leagues/edit.twig');
    }

    public function create(Request $request, Response $response, array $args): Response
    {        
        if (!$this->isAuthorizeToCreateLeagues()) {
            $response->getBody()->write("Unauthorised attempt to create new leauge.");
            return $response->withStatus(401);
        }

        $data = $request->getParsedBody();
        $leagueName = $data['league_name'] ?? '';
        $leagueDesc = $data['league_desc'] ?? '';
        $leagueSeason = (int) $data['league_season'];

        // validation
        $errors = [];
        if (empty($leagueName)) $errors[] = 'Cannot have league with an empty name.';
        if (League::where('name', $leagueName)->exists()) $errors[] = 'A league with that name already exists.';
        if ($errors) return $this->view->render($response, 'leagues/edit.twig', ['error' => $errors]);

        // save details
        $newLeague = League::create();
        $newLeague->name = $leagueName;
        $newLeague->description = htmlspecialchars($leagueDesc);
        $newLeague->season = $leagueSeason;
        $newLeague->coaches()->attach($this->userHelper->getCurrentUser()->id);
        $newLeague->save();

        return $this->view->render($response, 'leagues/creation_success.twig');
    }
}
