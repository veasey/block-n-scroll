<?php
use App\Models\Race;
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'home.twig');
});

$app->get('/rules', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'rules.twig');
});

$app->get('/rules/teams[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $teams = Race::all();

    if ($format === 'json') {
        $response->getBody()->write($teams->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/teams.twig', ['teams' => $teams]);
});
