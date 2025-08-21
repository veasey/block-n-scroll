<?php
namespace App\Controllers\Account;


use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Models\Coach;

use Slim\Views\Twig;


class ProfileController
{
    protected $view;

    public function __construct(
        Twig $view
    )
    {
        $this->view = $view;
    }

    public function view(Request $request, Response $response, array $args = []): Response
    {
        $user = Coach::find($args['user_id']);
        return $this->view->render($response, 'account/view.twig', ['coach' => $user]);
    }
}