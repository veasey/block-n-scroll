INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(120, 'Norse Raider Linemen', 'Lineman that hit hard', 'standard', 12, 6, 3, 3, 4, 8, 50000, 16),
(121, 'Beer Boars', 'Very cheap weak stunty, helps prone team-mates', 'special', 12, 5, 1, 3, NULL, 6, 20000, 2),
(122, 'Norse Berserker', 'Blitzer', 'standard', 12, 6, 3, 3, 5, 8, 90000, 2),
(123, 'Valkyrie', 'Ball handler and cage breaker', 'standard', 12, 7, 3, 3, 3, 8, 95000, 2),
(124, 'Ulfwerener', 'Strength 4 blocker', 'standard', 12, 6, 4, 4, NULL, 9, 105000, 2),
(125, 'Yhetee / Snow Troll', 'Big Guy', 'standard', 12, 5, 5, 4, NULL, 9, 140000, 1);

/* Norse Raider Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(120, 3, 1, 1),  -- G
(120, 4, 0, 1),  -- A
(120, 1, 0, 1),  -- P
(120, 2, 0, 1);  -- S

/* Beer Boars - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(121, 4, 0, 1);  -- A

/* 	Norse Berserker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(122, 3, 1, 0),  -- G
(122, 2, 1, 0),  -- S
(122, 4, 0, 1),  -- A
(122, 1, 0, 1);  -- P

/* Valkyrie - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(123, 4, 1, 0),  -- A
(123, 3, 1, 0),  -- G
(123, 1, 1, 0),  -- P
(123, 2, 0, 1);  -- S

/* Ulfwerener - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(124, 3, 1, 0),  -- G
(124, 2, 1, 0),  -- S
(124, 1, 0, 1);  -- A

/* 	Yhetee / Snow Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(125, 2, 1, 0),  -- S
(125, 1, 0, 1),  -- A
(125, 3, 0, 1);  -- G

/* Norse Raider Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(120, 1),  -- Block
(120, 54),  -- Thick Skull
(120, 77);  -- Drunkard

/* Beer Boars - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(121, 19),   -- Dodge
(121, 84),   -- No Hands
(121, 85),   -- Pick-me-up
(121, 95),   -- Stunty
(121, 101);  -- Titchy

/* Norse Berserker - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(122, 1),  -- Block
(122, 5),  -- Frenzy
(122, 20); -- Jump Up

/* Valkyrie - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(123, 15),  -- Catch
(123, 2),   -- Dauntless
(123, 37),  -- Pass
(123, 11);  -- Strip Ball

/* Ulfwerener - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(124, 5);  -- Frenzy

/* Yhetee / Snow Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(125, 56),  -- Claws
(125, 57),  -- Disturbing Presence
(125, 5),   -- Frenzy
(125, 82),  -- Loner
(125, 103); -- Unchannelled Fury

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(12, 4); -- Favoured Of (but only khorne or undivided)

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(12, 5); -- Old World Classic