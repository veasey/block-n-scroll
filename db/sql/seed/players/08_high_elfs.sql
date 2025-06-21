/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 8;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(80, 'Lineman', 'Standard High Elf lineman', 'standard', 8, 6, 3, 2, 4, 9, 70000, 16),
(81, 'Thrower', 'Accurate passer with multiple passing skills', 'standard', 8, 6, 3, 2, 2, 9, 100000, 2),
(82, 'Catcher', 'Fast receiver with Catch', 'standard', 8, 8, 3, 2, 5, 8, 90000, 4),
(83, 'Blitzer', 'Block specialist with good movement', 'standard', 8, 7, 3, 2, 4, 9, 100000, 2);

-- Lineman skill access
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(80, 3, 1, 0),  -- AG
(80, 2, 0, 1); -- S

-- Thrower skill access
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(81, 3, 1, 0),  -- AG
(81, 1, 1, 0),  -- P
(81, 2, 0, 1); -- S

-- Catcher skill access
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(82, 3, 1, 0),  -- AG
(82, 2, 0, 1); -- S

-- Blitzer skill access
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(83, 3, 1, 0),  -- AG
(83, 2, 0, 1); -- S

-- Thrower starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(81, 74),  -- Cloud Burster
(81, 30),  -- Pass
(81, 37);  -- Safe Throw

-- Catcher starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(82, 12);  -- Catch

-- Blitzer starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(83, 1);  -- Block

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(8, 2); -- elven kingdom
