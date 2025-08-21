<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Leagues\Shared\AccessController;
use App\Helpers\PaginationHelper;
use App\Helpers\UserHelper;
use App\Models\League;

use Slim\Views\Twig;


class ViewController extends AccessController
{
    protected $paginationHelper;
    protected $view;

    public function __construct(
        PaginationHelper $paginationHelper,
        UserHelper $userHelper,
        Twig $view
    )
    {
        $this->paginationHelper = $paginationHelper;
        $this->userHelper = $userHelper;
        $this->view = $view;
    }

    public function list(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';
        
        $params = $this->paginationHelper->getPaginationParams();
        $total = League::all()->count();
        $totalPages = ceil($total / $params['perPage']);
        
        $leagues = League::orderBy('created_at', 'desc')
                         ->skip($params['offset']) // offset
                         ->take($params['perPage']) // limit
                         ->get();

        if ($format === 'json') {
            $response->getBody()->write($leagues->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }
        
        return $this->view->render($response, 'team/list.twig', [
            'leagues' => $leagues,
            'page' => $params['page'],
            'totalPages' => $totalPages,
            'isAuthorizeToCreateLeagues' => $this->isAuthorizeToCreateLeagues()
        ]);
    }
}
