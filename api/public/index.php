<?php
require_once '../config/config.php';
require_once '../src/Database/Database.php';
require_once '../src/Controller/ApiController.php';

header('Content-Type: application/json');

$apiController = new ApiController();

$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = explode('/', trim($_SERVER['REQUEST_URI'], '/'));

if ($requestMethod === 'GET' && isset($requestUri[1]) && $requestUri[1] === 'data') {
    echo $apiController->getData();
} else {
    http_response_code(404);
    echo json_encode(['message' => 'Not Found']);
}
?>