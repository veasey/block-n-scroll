DELETE FROM base_team_player;
DELETE FROM base_team_player_skill;
DELETE FROM base_team_player_skill_category;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(1, 'Eagle Warrior Linewomen', 'Basic agile female warriors', 'standard', 1, 6, 3, 3, 4, 8, 70, 16),
(2, 'Python Warrior Throwers', 'Specialist who throws the ball', 'special', 1, 6, 3, 3, 3, 8, 90, 2),
(3, 'Piranha Warrior Blitzers', 'Stronger player skilled in blitzing', 'special', 1, 7, 3, 3, 5, 8, 110, 4),
(4, 'Jaguar Warrior Blockers', 'Tough players who protect the team', 'special', 1, 6, 4, 3, 5, 9, 110, 4);

-- Amazon Linewoman starting skills
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(1, 1, 1, 0),  -- General
(1, 2, 0, 1),  -- Agility (Secondary)
(1, 3, 0, 1);  -- Strength (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(1, 11);  -- Dodge

-- Amazon Thrower starting skills
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(2, 1, 1, 0),  -- General
(2, 4, 0, 1),  -- Passing
(2, 2, 0, 1),  -- Agility (Secondary)
(2, 3, 0, 1);  -- Strength (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(2, 11),   -- Dodge
(2, 72),   -- On The Ball
(2, 36),   -- Pass
(2, 37);   -- Safe Throw (Safe Pass)

-- Amazon Blitzer starting skills
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(3, 2, 1, 0),  -- Agility (Primary)
(3, 1, 1, 0),  -- General (Secondary)
(3, 3, 0, 1);  -- Strength (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(3, 11),   -- Dodge
(3, 59),   -- Hit and Run
(3, 17);   -- Jump Up

-- Amazon Blocker starting skills
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(4, 1, 1, 0),  -- General (Primary)
(4, 3, 1, 0),  -- Strength (Primary)
(4, 2, 0, 1);  -- Agility (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(4, 11),   -- Dodge
(4, 71);   -- Defensive

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(1, 4);