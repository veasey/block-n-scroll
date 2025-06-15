# players

CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    team_id INT NOT NULL,          -- FK to teams table
    race_id INT NOT NULL,          -- FK to races table
    position_id INT NOT NULL,      -- FK to positions table
    name VARCHAR(100) NOT NULL,
    number INT,                    -- jersey number, optional
    spp INT DEFAULT 0,             -- experience points
    level ENUM('Journeyman', 'Rookie', 'Experienced', 'Veteran', 'Emerging Star', 'Star', 'Superstar', 'Legend') DEFAULT 'Rookie',
    status ENUM('active', 'injured', 'dead', 'retired') DEFAULT 'active',
    
    ma INT NOT NULL,                -- Movement Allowance
    st INT NOT NULL,                -- Strength
    ag INT NOT NULL,                -- Agility
    av INT NOT NULL,                -- Armor Value
    pa INT DEFAULT NULL,               -- Passing ability (optional)

    niggling_injury TINYINT(1) DEFAULT 0, -- Is this player suffering from niggling injuries?
    miss_next_game TINYINT(1) DEFAULT 0,  -- Is this player missing the next game?
    dead TINYINT(1) DEFAULT 0,            -- Is this player dead?

    /* Match records */
    touchdowns INT DEFAULT 0,
    casualties INT DEFAULT 0,
    injuries INT DEFAULT 0,
    completions INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    sacks INT DEFAULT 0,
    blocks_made INT DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (position_id) REFERENCES player_position(id)
);