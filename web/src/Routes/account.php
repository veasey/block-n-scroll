<?php
use App\Controllers\Account\LoginController;
use App\Controllers\Account\RegisterController;

$app->get('/account/login', LoginController::class . ':showLoginForm');
$app->post('/account/login', LoginController::class . ':login');
$app->get('/account/register', RegisterController::class . ':showRegisterForm');
$app->post('/account/register', RegisterController::class . ':register');