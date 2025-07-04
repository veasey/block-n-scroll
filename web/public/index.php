<?php

use Slim\Factory\AppFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;
use DI\Container;
use Illuminate\Database\Capsule\Manager as Capsule;

require __DIR__ . '/../vendor/autoload.php';

// Create Container
$container = new Container();
AppFactory::setContainer($container);

// Create App
$app = AppFactory::create();
$app->addRoutingMiddleware();

// Register Twig in container
$container->set(Twig::class, function () {
    return Twig::create(__DIR__ . '/../templates', ['cache' => false]);
});

// Add Twig middleware using the container instance
$app->add(TwigMiddleware::create($app, $container->get(Twig::class)));

// Load DB
require __DIR__ . '/../src/bootstrap.php';

// Register your controller in container
$container->set(App\Controllers\Rules\TeamController::class, function ($c) {
    return new App\Controllers\Rules\TeamController(
        $c->get(Twig::class)
    );
});

// Load routes
require __DIR__ . '/../src/Routes/web.php';
require __DIR__ . '/../src/Routes/rules.php';

$app->run();
