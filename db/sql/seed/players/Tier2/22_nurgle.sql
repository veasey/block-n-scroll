update base_team SET reroll_cost = 70 WHERE id = 22;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(220, 'Rotter', 'Zombie lineman', 'standard', 22, 5, 3, 4, 6, 9, 35000, 12),
(221, 'Bloater', 'Blocker', 'standard', 22, 4, 4, 4, 6, 10, 75000, 4),
(222, 'Pestigor', 'Blitzer and ball handler', 'standard', 22, 6, 3, 3, 4, 9, 115000, 4),
(223, 'Rotspawn', 'Big Guy, good road block.', 'special', 22, 4, 5, 5, NULL, 10, 140000, 1);

/* Rotter - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(220, 1, 1, 0), -- General
(220, 5, 1, 0), -- Mutations
(220, 3, 0, 1), -- Agility
(220, 2, 0, 1); -- Strength

/* Chaos Bloater - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(221, 1, 1, 0), -- General
(221, 5, 1, 0), -- Mutations
(221, 2, 1, 0), -- Strength
(221, 3, 0, 1); -- Agility

/* Pestigor - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(222, 1, 1, 0), -- General
(222, 5, 1, 0), -- Mutations
(222, 2, 1, 0), -- Strength
(222, 3, 0, 1), -- Agility
(222, 4, 0, 1); -- Passing

/* Rotspawn- Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(223, 2, 1, 0), -- Strength
(223, 3, 0, 1), -- Agility
(223, 1, 0, 1), -- General
(223, 5, 0, 1); -- Mutations

/* Rotter - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(220, 76), -- Decay
(220, 86); -- Plague Ridden

/* Bloater - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(221, 86), -- Plague Ridden
(221, 90), -- Regeneration
(221, 57), -- Disturbing Presence
(221, 59); -- Foul Appearance

/* Pestigor - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(222, 60), -- Horns
(222, 86), -- Plague Ridden
(222, 90); -- Regeneration

/* Rotspawn - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(223, 90), -- Regeneration
(223, 48), -- Mighty Blow
(223, 57), -- Disturbing Presence
(223, 82), -- Loner
(223, 89), -- Really Stupid
(223, 59), -- Foul Appearance
(223, 86), -- Plague Ridden
(223, 64); -- Tentacles

/* Chaos Team Special Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(17, 4); -- Favoured of Nurgle