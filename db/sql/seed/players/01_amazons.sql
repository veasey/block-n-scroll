DELETE FROM player_position;

INSERT INTO player_position
(id, name, description, category, race_id, regional_special_rules_id, ma, st, ag, pa, av, primary_skills, secondary_skills, cost, max_count)
VALUES
(1, 'Amazon Linewoman', 'Basic agile female warriors', 'standard', 1, 4, 7, 3, 4, 3, 7, 'Agility', 'General', 70, 16),
(2, 'Amazon Thrower', 'Specialist who throws the ball', 'special', 1, 4, 7, 3, 4, 5, 7, 'Passing', 'Agility', 90, 2),
(3, 'Amazon Blitzer', 'Stronger player skilled in blitzing', 'special', 1, 4, 7, 4, 3, 3, 8, 'Strength', 'Agility', 110, 4);

-- Amazon Linewoman starting skills
INSERT INTO player_starting_skills (player_position_id, skill_id) VALUES
(1, 11),  -- Dodge
(1, 37),  -- Safe Throw (Pass)
(1, 1),   -- Block
(1, 12);  -- Catch

-- Amazon Thrower starting skills
INSERT INTO player_starting_skills (player_position_id, skill_id) VALUES
(2, 37),  -- Safe Throw (Pass)
(2, 11),  -- Dodge
(2, 12);  -- Catch

-- Amazon Blitzer starting skills
INSERT INTO player_starting_skills (player_position_id, skill_id) VALUES
(3, 1),   -- Block
(3, 11);  -- Dodge
