/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 6;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(60, 'Linemen', 'Basic Elven Union player', 'standard', 6, 6, 3, 2, 4, 8, 60000, 12),
(61, 'Thrower', 'Skilled passer with Pass skill', 'standard', 6, 6, 3, 2, 2, 8, 75000, 2),
(62, 'Catcher', 'Fast, with Catch and Nerves of Steel', 'standard', 6, 8, 3, 2, 4, 8, 100000, 4),
(63, 'Blitzer', 'Powerful, with Block and Side Step', 'standard', 6, 7, 3, 2, 3, 9, 115000, 2);

-- Linemen
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(60, 3, 1, 0),  -- AG
(60, 2, 0, 1); -- S

-- Thrower
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(61, 3, 1, 0),  -- AG
(61, 1, 1, 0),  -- P
(61, 2, 0, 1); -- S

-- Catcher
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(62, 3, 1, 0),  -- AG
(62, 2, 0, 1); -- S

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(63, 3, 1, 0),  -- AG
(63, 2, 0, 1); -- S

-- Thrower (Pass)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(61, 37);  -- Pass

-- Catcher (Catch, Nerves of Steel)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(62, 15),  -- Catch
(62, 35);  -- Nerves of Steel

-- Blitzer (Block, Side Step)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(63, 1),  -- Block
(63, 23); -- Side Step

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(6, 2); -- elven kingdom