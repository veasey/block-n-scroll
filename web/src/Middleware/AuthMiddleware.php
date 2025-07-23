<?php
namespace App\Middleware;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class AuthMiddleware
{
    public function __invoke(Request $request, Response $response, $next)
    {
        if (empty($_SESSION['user_id'])) {
            return $response
                ->withHeader('Location', '/login')
                ->withStatus(302);
        }
        return $next($request, $response);
    }
}