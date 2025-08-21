<?php
use App\Controllers\Account\LoginController;
use App\Controllers\Account\RegisterController;
use App\Controllers\Account\ProfileController;

$app->get('/account/login', LoginController::class . ':showLoginForm');
$app->post('/account/login', LoginController::class . ':login');
$app->post('/account/logout', LoginController::class . ':logout');

$app->get('/account/register', RegisterController::class . ':showRegisterForm');
$app->post('/account/register', RegisterController::class . ':register');

$app->get('/account/{user_id}/view', ProfileController::class . ':view');