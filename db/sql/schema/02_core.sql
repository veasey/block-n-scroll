# coaches, leagues, teams

CREATE TABLE coach (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    password_hash VARCHAR(255) NOT NULL,
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
    assistant_coaches INT DEFAULT 0,
    cheerleaders INT DEFAULT 0,
    fan_factor INT DEFAULT 0,
    status ENUM('fresh', 'playing', 'idle', 'retired') DEFAULT 'fresh',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (coach_id) REFERENCES coach(id),
    FOREIGN KEY (base_team_id) REFERENCES base_team(id),
    FOREIGN KEY (league_id) REFERENCES league(id)
);

CREATE TABLE side_staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost INT NOT NULL,
    max_count INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);