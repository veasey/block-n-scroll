<?php
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Models\MatchGame as Matches;

$app->get('/', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'home.twig', ['matches' => Matches::orderBy('created_at', 'desc')->take(9)->get()]);
});