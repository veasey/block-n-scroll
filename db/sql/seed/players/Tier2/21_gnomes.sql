/* reroll cost */
UPDATE base_team SET reroll_cost = 50000 WHERE id = 21;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(210, 'Gnome linemen', 'Lineman', 'standard', 21, 5, 2, 3, 4, 7, 40000, 16),
(211, 'Gnome Illusionist', 'Cage and Line Breaker', 'standard', 21, 5, 2, 3, 3, 7, 50000, 2),
(212, 'Woodland Fox', 'Scorer', 'special', 21, 7, 2, 2, NULL, 6, 50000, 2), 
(213, 'Gnome Beastmaster', 'Blocker', 'standard', 21, 5, 2, 3, 4, 8, 55000, 2),
(214, 'Altern Forest Treeman', 'Big Guy', 'standard', 21, 2, 6, 5, 5, 11, 120000, 2);

/* Gnome linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(210, 3, 0, 1), -- Agility
(210, 1, 1, 0), -- General
(210, 2, 0, 1); -- Strength

/* Gnome Illusionist - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(211, 3, 1, 0), -- Agility
(211, 4, 1, 0), -- Passing
(211, 1, 0, 1); -- General

/* Woodland Fox - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(212, 3, 0, 1); -- Agility

/* Gnome Beastmaster - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(213, 3, 0, 1), -- Agility
(213, 1, 1, 0), -- General
(213, 2, 1, 0); -- Strength

/* Altern Treeman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(214, 2, 1, 0), -- Strength
(214, 3, 0, 1), -- Agility
(214, 1, 0, 1), -- General
(214, 4, 0, 1); -- Passing

/* Gnome Lineman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(210, 20), -- Jump Up
(210, 91), -- Right Stuff
(210, 95), -- Stunty
(210, 14); -- Wrestle

/* Gnome Illusionist - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(211, 20),  -- Jump Up
(211, 102), -- Trickster
(211, 95),  -- Stunty
(211, 14);  -- Wrestle

/* Woodland Fox - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(212, 19), -- Dodge
(212, 83), -- My Ball
(212, 95), -- Stunty
(212, 23); -- Side Step

/* Gnome Beastmaster - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(213, 20), -- Jump Up
(213, 46), -- Guard
(213, 95), -- Stunty
(213, 14); -- Wrestle

/* Altern Forest Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(214, 82),  -- Loner
(214, 48),  -- Mighty Blow
(214, 52),  -- Stand Firm
(214, 53),  -- Strong Arm
(214, 98),  -- Take Root
(214, 54),  -- Thick Skull
(214, 99),  -- Throw Team Mate
(214, 100); -- Timmm-ber!

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(21, 3); -- alfling Thimble Cup