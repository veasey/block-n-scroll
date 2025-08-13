# skills, injuries, inducements

CREATE TABLE skill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT NOT NULL,
    description TEXT
);

/* linker table for skills aquired by players */
CREATE TABLE base_team_player_skill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    base_team_player_id INT NOT NULL,
    skill_id INT NOT NULL,
    FOREIGN KEY (base_team_player_id) REFERENCES base_team_player(id),
    FOREIGN KEY (skill_id) REFERENCES skill(id),
    UNIQUE(base_team_player_id, skill_id)  -- prevent duplicate skill assignments
);

CREATE TABLE casualty (
    roll_start INT NOT NULL,
    roll_end INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    effect VARCHAR(255),
    permanent BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (roll_start, roll_end)
);

CREATE TABLE injury (
    d6_roll INT PRIMARY KEY,
    injury_type VARCHAR(50) NOT NULL,
    characteristic VARCHAR(10) NOT NULL,
    reduction INT NOT NULL
);

CREATE TABLE player_skill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    skill_id INT NOT NULL,
    acquired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES player(id),
    FOREIGN KEY (skill_id) REFERENCES skill(id),
    UNIQUE(player_id, skill_id)  -- prevent duplicate skill assignments
);