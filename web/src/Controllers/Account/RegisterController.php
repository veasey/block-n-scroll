<?php
namespace App\Controllers\Account;

use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Models\Coach;

class RegisterController
{
    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function showRegisterForm(Request $request, Response $response, array $args = []): Response
    {
        return $this->view->render($response, 'account/register.twig');
    }

    public function register(Request $request, Response $response, array $args = []): Response
    {
        $data = $request->getParsedBody();
        $username = trim($data['username'] ?? '');
        $email = trim($data['email'] ?? '');
        $password = $data['password'] ?? '';
        $password_confirm = $data['password_confirm'] ?? '';

        $errors = [];

        // Check if username exists
        if (Coach::where('name', $username)->exists()) {
            $errors[] = 'Username already exists.';
        }

        // Check if email exists
        if (Coach::where('email', $email)->exists()) {
            $errors[] = 'Email already exists.';
        }

        // Check if passwords match
        if ($password !== $password_confirm) {
            $errors[] = 'Passwords do not match.';
        }

        // If errors, show form again with errors
        if ($errors) {
            return $this->view->render($response, 'account/register.twig', [
                'errors' => $errors,
                'username' => $username,
                'email' => $email
            ]);
        }

        // Create new coach
        $coach = new \App\Models\Coach();
        $coach->name = $username;
        $coach->email = $email;
        $coach->password_hash = password_hash($password, PASSWORD_DEFAULT);
        $coach->save();
        
        return $response->withHeader('Location', '/account/login')->withStatus(302);
    }
}