# players, player stats

CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT NOT NULL,          -- FK to teams table
    race_id INT NOT NULL,          -- FK to races table
    position_id INT NOT NULL,      -- FK to positions table
    name VARCHAR(100) NOT NULL,
    number INT,                   -- jersey number, optional
    experience INT DEFAULT 0,     -- experience points
    status ENUM('active', 'injured', 'dead', 'retired') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (position_id) REFERENCES player_positions(id)
);

CREATE TABLE player_stats (
    player_id INT PRIMARY KEY,      -- FK to players.id, one-to-one
    ma INT NOT NULL,                -- Movement Allowance
    st INT NOT NULL,                -- Strength
    ag INT NOT NULL,                -- Agility
    av INT NOT NULL,                -- Armor Value
    passing INT DEFAULT 0,          -- Passing ability (optional)
    catching INT DEFAULT 0,         -- Catching ability (optional)
    blocking INT DEFAULT 0,         -- Blocking ability (optional)
    injury_points INT DEFAULT 0,    -- Tracks injury penalties or reductions
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE player_game_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    touchdowns INT DEFAULT 0,
    casualties INT DEFAULT 0,
    injuries INT DEFAULT 0,
    passes_completed INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    sacks INT DEFAULT 0,
    blocks_made INT DEFAULT 0,
    mv_points INT DEFAULT 0,       -- e.g. movement points gained
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);

CREATE TABLE player_injuries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    injury_type VARCHAR(50) NOT NULL,  -- e.g. "Mild", "Severe", "Career-ending"
    description TEXT,                  -- Detailed description of the injury
    date_incurred DATE NOT NULL,       -- When the injury was incurred
    recovery_time INT DEFAULT 0,       -- Estimated recovery time in days
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE player_match_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    touchdowns INT DEFAULT 0,
    casualties INT DEFAULT 0,
    completions INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    mvps INT DEFAULT 0,
    spp_earned INT DEFAULT 0,
    injuries_sustained TEXT,
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);