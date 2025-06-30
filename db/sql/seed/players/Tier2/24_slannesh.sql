/* Hide Team */
update base_team SET is_hidden = true WHERE id = 24;

/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 24;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(241, 'Daemonettes', 'Lineman', 'standard', 24, 6, 3, 2, 4, 8, 60000, 16),
(242, 'Slaangors', 'Blizter', 'standard', 24, 7, 3, 2, 3, 8, 100000, 4),
(243, 'Slaanesh Warriors', 'Cage breakers', 'special', 24, 6, 4, 3, 5, 9, 110000, 4);

/* Daemonettes - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(241, 1, 1, 0), -- General
(241, 3, 1, 0), -- Agility
(241, 5, 1, 0), -- Mutations
(241, 2, 0, 1), -- Strength
(241, 4, 0, 1); -- Passing

/* Slaangors - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(242, 1, 1, 0), -- General
(242, 3, 1, 0), -- Agility
(242, 5, 1, 0), -- Mutations
(242, 2, 0, 1), -- Strength
(242, 4, 0, 1); -- Passing

/* Slaangors - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(242, 60), -- Horns
(242, 63); -- Prehensile Tail

/* Slaanesh Warriors - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(243, 56), -- Claws
(243, 66); -- Very Long Legs

/* Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(24, 4); -- Favoured Of Slaanesh