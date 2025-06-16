<?php

use Slim\Factory\AppFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();
$app->addRoutingMiddleware();

$twig = Twig::create(__DIR__ . '/../templates', ['cache' => false]);
$app->add(TwigMiddleware::create($app, $twig));

// Load DB
require __DIR__ . '/../src/bootstrap.php';

// Load routes
require __DIR__ . '/../src/Routes/web.php';
require __DIR__ . '/../src/Routes/rules.php';

$app->run();