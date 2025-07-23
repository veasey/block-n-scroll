<?php
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'home.twig');
});