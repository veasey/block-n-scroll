<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Models\Team;

class ApiController
{
    public function checkName (Request $request, Response $response): Response {
        $name = $_GET['name'] ?? '';
        $exists = (bool) Team::where('name', $name)->first();
        $payload = json_encode(['unique' => !$exists]);
        $response->getBody()->write($payload);
        return $response->withHeader('Content-Type', 'application/json');
    }   
}