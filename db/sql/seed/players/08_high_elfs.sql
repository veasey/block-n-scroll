INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(80, 'Lineman', 'Standard High Elf lineman', 'standard', 8, 6, 3, 2, 4, 9, 70000, 16),
(81, 'Thrower', 'Accurate passer with multiple passing skills', 'standard', 8, 6, 3, 2, 2, 9, 100000, 2),
(82, 'Catcher', 'Fast receiver with Catch', 'standard', 8, 8, 3, 2, 5, 8, 90000, 4),
(83, 'Blitzer', 'Block specialist with good movement', 'standard', 8, 7, 3, 2, 4, 9, 100000, 2);

-- Lineman
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(80, 3, 'primary'),  -- AG
(80, 2, 'secondary'); -- S

-- Thrower
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(81, 3, 'primary'),  -- AG
(81, 1, 'primary'),  -- P
(81, 2, 'secondary'); -- S

-- Catcher
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(82, 3, 'primary'),  -- AG
(82, 2, 'secondary'); -- S

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(83, 3, 'primary'),  -- AG
(83, 2, 'secondary'); -- S

-- Thrower (Cloud Burster, Pass, Safe Pass)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(81, 105),  -- Cloud Burster
(81, 101),  -- Pass
(81, 106);  -- Safe Pass

-- Catcher (Catch)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(82, 102);  -- Catch

-- Blitzer (Block)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(83, 1);  -- Block

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, special_rule_id) VALUES
(8, 2); -- elven kingdom
