/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 6;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(60, 'Linemen', 'Basic Elven Union player', 'standard', 6, 6, 3, 2, 4, 8, 60000, 12),
(61, 'Thrower', 'Skilled passer with Pass skill', 'standard', 6, 6, 3, 2, 2, 8, 75000, 2),
(62, 'Catcher', 'Fast, with Catch and Nerves of Steel', 'standard', 6, 8, 3, 2, 4, 8, 100000, 4),
(63, 'Blitzer', 'Powerful, with Block and Side Step', 'standard', 6, 7, 3, 2, 3, 9, 115000, 2);

/* Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(60, 2, 1, 0), -- Agility
(60, 1, 1, 0), -- General
(60, 3, 0, 1); -- Strength

/* Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(61, 2, 1, 0), -- Agility
(61, 1, 1, 0), -- General
(61, 4, 1, 0); -- Passing
(61, 3, 0, 1); -- Strength

/* Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(62, 2, 1, 0), -- Agility
(62, 1, 1, 0), -- General
(62, 3, 0, 1); -- Strength

/* Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(63, 2, 1, 0), -- Agility
(63, 1, 1, 0), -- General
(63, 4, 0, 1); -- Passing
(63, 3, 0, 1); -- Strength

/* Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(61, 37); -- Pass

/* Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(62, 15), -- Catch
(62, 35); -- Nerves of Steel

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(63, 1),  -- Block
(63, 23); -- Side Step

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(6, 2); -- elven kingdom