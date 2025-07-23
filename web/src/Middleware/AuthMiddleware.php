<?php
namespace App\Middleware;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Psr7\Response as SlimResponse;

class AuthMiddleware
{
    public function __invoke(Request $request, RequestHandlerInterface $handler): Response
    {
        if (empty($_SESSION['user_id'])) {
            $_SESSION['redirect_after_login'] = (string)$request->getUri();

            $response = new SlimResponse();
            return $response
                ->withHeader('Location', '/account/login')
                ->withStatus(302);
        }

        return $handler->handle($request);
    }
}
