# coaches, leagues, teams

CREATE TABLE coaches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('coach', 'moderator', 'admin') DEFAULT 'coach'
);

CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position_id INT,
    team_id INT,
    coach_id INT,
    current_value INT,
    spp INT DEFAULT 0,
    injuries TEXT,
    FOREIGN KEY (position_id) REFERENCES player_positions(id),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (coach_id) REFERENCES coaches(id)
);

CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    race_id INT,
    league_id INT,
    treasury INT DEFAULT 1000000,
    rerolls INT DEFAULT 0,
    apothecary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (league_id) REFERENCES leagues(id)
);

CREATE TABLE leagues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    season INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);