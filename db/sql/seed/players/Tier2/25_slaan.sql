/* Hide Team */
update base_team SET is_hidden = true WHERE id = 25;

/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 25;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(250, 'Lineman', 'Lineman', 'standard', 25, 6, 3, 3, 4, 9, 60000, 16),
(251, 'Slaan Catcher', 'Catcher', 'standard', 25, 7, 2, 2, 4, 8, 80000, 4),
(252, 'Slaane Blitzer', 'Blitzer', 'special', 25, 7, 3, 3, 4, 9, 110000, 4),
(253, 'Kroxigor', 'A big guy that you cannot dodge away from', 'special', 25, 6, 5, 5, NULL, 10, 140000, 1);

/* Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(250, 1, 1, 0), -- General
(250, 3, 0, 1), -- Agility
(250, 2, 0, 1); -- Strength

/* Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(251, 3, 1, 0), -- Agility
(251, 1, 1, 0), -- General
(251, 2, 0, 1), -- Strength
(251, 4, 0, 1); -- Passing

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id, is_primary, is_secondary) VALUES
(252, 3, 1, 0), -- Agility
(252, 1, 1, 0), -- General
(252, 2, 1, 0), -- Strength
(252, 4, 0, 1); -- Passing

/* Kroxigor - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id, is_primary, is_secondary) VALUES
(253, 2, 1, 0), -- Strength
(253, 3, 0, 1), -- Agility
(253, 1, 0, 1); -- General

/* Lineman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id, is_primary, is_secondary) VALUES
(250, 87), -- Pogo Stick
(250, 66); -- Very Long Legs

/* Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id, is_primary, is_secondary) VALUES
(251, 87), -- Pogo Stick
(251, 66), -- Very Long Legs
(251, 17); -- Diving Catch

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id, is_primary, is_secondary) VALUES
(252, 87), -- Pogo Stick
(252, 66), -- Very Long Legs
(252, 18), -- Diving Tackle
(252, 20); -- Jump Up

/* Kroxigor - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(253, 73), -- Bone-head
(253, 82), -- Loner
(253, 48), -- Mighty Blow
(253, 63), -- Prehensile Tail
(253, 54); -- Thick Skull

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(25, 4); -- Lustrian SuperLeague