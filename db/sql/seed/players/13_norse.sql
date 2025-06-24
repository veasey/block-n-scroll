INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(130, 'Norse Raider Linemen', 'Lineman that hit hard', 'standard', 
13, 6, 3, 3, 4, 8, 50000, 16),
(131, 'Beer Boars', 'Very cheap weak stunty, helps prone team-mates', 'special', 
13, 5, 1, 3, NULL, 6, 20000, 2),
(132, 'Norse Berserker', 'Blitzer', 'standard', 
13, 6, 3, 3, 5, 8, 90000, 2),
(133, 'Valkyrie', 'Ball handler and cage breaker', 'standard', 
13, 7, 3, 3, 3, 8, 95000, 2),
(134, 'Ulfwerener', 'Strength 4 blocker', 'standard', 
13, 6, 4, 4, NULL, 9, 105000, 2),
(135, 'Yhetee / Snow Troll', 'Big Guy', 'standard', 
13, 5, 5, 4, NULL, 9, 140000, 1);

/* Norse Raider Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(130, 3, 1, 1),  -- G
(130, 4, 0, 1),  -- A
(130, 1, 0, 1),  -- P
(130, 2, 0, 1);  -- S

/* Beer Boars - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(131, 4, 0, 1);  -- A

/* 	Norse Berserker - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(132, 3, 1, 0),  -- G
(132, 2, 1, 0),  -- S
(132, 4, 0, 1),  -- A
(132, 1, 0, 1);  -- P

/* Valkyrie - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(133, 4, 1, 0),  -- A
(133, 3, 1, 0),  -- G
(133, 1, 1, 0),  -- P
(133, 2, 0, 1);  -- S

/* Ulfwerener - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(134, 3, 1, 0),  -- G
(134, 2, 1, 0),  -- S
(134, 1, 0, 1);  -- A

/* 	Yhetee / Snow Troll - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(135, 2, 1, 0),  -- S
(135, 1, 0, 1),  -- A
(135, 3, 0, 1);  -- G

/* Norse Raider Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(130, 1),  -- Block
(130, 54),  -- Thick Skull
(130, 77);  -- Drunkard

/* Beer Boars - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(131, 19),   -- Dodge
(131, 84),   -- No Hands
(131, 85),   -- Pick-me-up
(131, 95),   -- Stunty
(131, 101);  -- Titchy

/* Norse Berserker - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(132, 1),  -- Block
(132, 5),  -- Frenzy
(132, 20); -- Jump Up

/* Valkyrie - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(133, 15),  -- Catch
(133, 2),   -- Dauntless
(133, 37),  -- Pass
(133, 11);  -- Strip Ball

/* Ulfwerener - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(134, 5);  -- Frenzy

/* Yhetee / Snow Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(135, 56),  -- Claws
(135, 57),  -- Disturbing Presence
(135, 5),   -- Frenzy
(135, 82),  -- Loner
(135, 103); -- Unchannelled Fury

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(13, 4) -- Favoured Of (but only khorne or undivided)

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(13, 5); -- Old World Classic