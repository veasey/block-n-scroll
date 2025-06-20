INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(70, 'Linemen', 'Basic Elven Union player', 'standard', 7, 6, 3, 2, 4, 8, 60000, 12),
(71, 'Thrower', 'Skilled passer with Pass skill', 'standard', 7, 6, 3, 2, 2, 8, 75000, 2),
(72, 'Catcher', 'Fast, with Catch and Nerves of Steel', 'standard', 7, 8, 3, 2, 4, 8, 100000, 4),
(73, 'Blitzer', 'Powerful, with Block and Side Step', 'standard', 7, 7, 3, 2, 3, 9, 115000, 2);

-- Linemen
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(70, 3, 1, 0),  -- AG
(70, 2, 0, 1); -- S

-- Thrower
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(71, 3, 1, 0),  -- AG
(71, 1, 1, 0),  -- P
(71, 2, 0, 1); -- S

-- Catcher
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(72, 3, 1, 0),  -- AG
(72, 2, 0, 1); -- S

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(73, 3, 1, 0),  -- AG
(73, 2, 0, 1); -- S

-- Thrower (Pass)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(71, 75);  -- Pass

-- Catcher (Catch, Nerves of Steel)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(72, 12),  -- Catch
(72, 38);  -- Nerves of Steel

-- Blitzer (Block, Side Step)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(73, 1),  -- Block
(73, 18); -- Side Step

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(7, 2); -- elven kingdom