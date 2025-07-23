<?php
namespace App\Controllers\Auth;

use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class LoginController
{
    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function showLoginForm(Request $request, Response $response, array $args = []): Response
    {
        return $this->view->render($response, 'auth/login.twig');
    }

    public function login(Request $request, Response $response, array $args = []): Response
    {
        $data = $request->getParsedBody();
        $username = $data['username'] ?? '';
        $password = $data['password'] ?? '';

        // Replace this with your real user lookup and password check
        if ($username === 'admin' && $password === 'password') {
            $_SESSION['user_id'] = 1;
            $_SESSION['username'] = $username;
            return $response->withHeader('Location', '/team')->withStatus(302);
        }

        // On failure, show form with error
        return $this->view->render($response, 'auth/login.twig', [
            'error' => 'Invalid username or password.',
            'username' => $username
        ]);
    }

    public function logout(Request $request, Response $response): Response
    {
        unset($_SESSION['user_id']);
        unset($_SESSION['username']);
        return $response->withHeader('Location', '/login')->withStatus(302);
    }
}