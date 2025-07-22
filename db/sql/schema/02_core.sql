# coaches, leagues, teams

CREATE TABLE coach (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('coach', 'moderator', 'admin') DEFAULT 'coach'
);

CREATE TABLE league (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    season INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE team (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    coach_id INT,
    base_team_id INT,
    league_id INT,
    treasury INT DEFAULT 1000000,
    rerolls INT DEFAULT 0,
    apothecary BOOLEAN DEFAULT FALSE,
    is_fresh BOOLEAN DEFAULT TRUE, -- Team not yet in a league
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (coach_id) REFERENCES coach(id),
    FOREIGN KEY (base_team_id) REFERENCES base_team(id),
    FOREIGN KEY (league_id) REFERENCES league(id)
);