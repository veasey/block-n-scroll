# skills, injuries, inducements

CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    description TEXT
);

CREATE TABLE injury_casualty_table (
    roll_start INT NOT NULL,
    roll_end INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    effect VARCHAR(255),
    permanent BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (roll_start, roll_end)
);

CREATE TABLE lasting_injury_table (
    d6_roll INT PRIMARY KEY,
    injury_type VARCHAR(50) NOT NULL,
    characteristic VARCHAR(10) NOT NULL,
    reduction INT NOT NULL
);

CREATE TABLE player_skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    skill_id INT NOT NULL,
    acquired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id),
    UNIQUE(player_id, skill_id)  -- prevent duplicate skill assignments
);
