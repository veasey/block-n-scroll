<?php
use App\Controllers\Auth\LoginController;

$app->get('/login', LoginController::class . ':showLoginForm');
$app->post('/login', LoginController::class . ':login');