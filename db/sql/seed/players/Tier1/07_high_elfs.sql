/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 7;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(70, 'Lineman', 'Standard High Elf lineman', 'standard', 7, 6, 3, 2, 4, 9, 70000, 16),
(71, 'Thrower', 'Accurate passer with multiple passing skills', 'standard', 7, 6, 3, 2, 2, 9, 100000, 2),
(72, 'Catcher', 'Fast receiver with Catch', 'standard', 7, 8, 3, 2, 5, 8, 90000, 4),
(73, 'Blitzer', 'Block specialist with good movement', 'standard', 7, 7, 3, 2, 4, 9, 100000, 2);

/* Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(70, 3, 1, 0), -- A
(70, 2, 0, 1); -- S

/* Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(71, 3, 1, 0), -- A
(71, 1, 1, 0), -- P
(71, 2, 0, 1); -- S

/* Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(72, 3, 1, 0), -- AG
(72, 2, 0, 1); -- S

/* Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(73, 3, 1, 0), -- AG
(73, 2, 0, 1); -- S

/* Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(71, 29),  -- Cloud Burster
(71, 37),  -- Pass
(71, 40);  -- Safe Pass

/* Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(72, 15);  -- Catch

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(73, 1);  -- Block

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(7, 2); -- elven kingdom
