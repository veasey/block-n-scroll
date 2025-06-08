<?php
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../../');
$dotenv->load();

return [
    'database' => [
        'host' => $_ENV['MYSQL_HOST'],
        'username' => $_ENV['MYSQL_USER'],
        'password' => $_ENV['MYSQL_PASSWORD'],
        'dbname' => $_ENV['MYSQL_DATABASE'],
    ],
    'app' => [
        'debug' => $_ENV['APP_DEBUG'],
        'base_url' => $_ENV['APP_URL'],
    ],
];