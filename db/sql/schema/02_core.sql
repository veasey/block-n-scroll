# coaches, leagues, teams

CREATE TABLE coaches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('coach', 'moderator', 'admin') DEFAULT 'coach'
);

CREATE TABLE leagues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    season INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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