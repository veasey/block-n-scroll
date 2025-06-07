# races and positions

CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    tier INT
);

CREATE TABLE player_positions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    category ENUM('standard', 'special', 'star') DEFAULT 'standard',
    race_id INT,
    ma INT,
    st INT,
    ag INT,
    pa INT,
    av INT,
    primary_skills VARCHAR(255),
    secondary_skills VARCHAR(255),
    cost INT,
    FOREIGN KEY (race_id) REFERENCES races(id)
);