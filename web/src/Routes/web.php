<?php

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Models\Race;

$app->get('/', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'home.twig');
});

$app->get('lookup/teams[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $teams = Race::get();

    if ($format === 'json') {
        $response->getBody()->write($teams->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'teams.twig', ['teams' => $teams]);
});
