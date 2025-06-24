INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(140, 'Orc Linemen', 'Cheap and high armour linemen', 'standard', 
14, 5, 3, 3, 4, 10, 50000, 16),
(141, 'Orc Thrower', 'Vulnerable Orc who can pick up the ball', 'standard', 
14, 5, 3, 3, 3, 9, 65000, 2),
(142, 'Orc Blitzer', 'Blitzer', 'standard', 
14, 6, 3, 3, 4, 10, 80000, 4),
(143, 'Orc Big Un', 'Strength 4 Blocker', 'standard', 
14, 5, 4, 4, NULL, 10, 90000, 4),
(144, 'Goblin', 'Stunty', 'standard', 
14, 6, 2, 3, 4, 8, 40000, 4),
(145, 'Untrained Troll', 'Big Guy', 'standard', 
14, 4, 5, 5, 5, 10, 115000, 1);

/* Orc Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(140, 3, 1, 1),  -- G
(140, 4, 0, 1),  -- A
(140, 2, 0, 1);  -- S

/* Orc Thrower - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(141, 3, 1, 0),  -- G
(141, 1, 1, 0),  -- P
(141, 4, 0, 1),  -- A
(141, 2, 0, 1);  -- S

/* 	Orc Blitzer - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(142, 3, 1, 0),  -- G
(142, 2, 1, 0),  -- S
(142, 4, 0, 1),  -- A
(142, 1, 0, 1);  -- P

/* Orc Big Un - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(143, 3, 1, 0),  -- G
(143, 2, 1, 0),  -- S
(143, 1, 0, 1);  -- A

/* Goblin - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(144, 1, 0, 1),  -- A
(144, 3, 1, 0),  -- G
(144, 2, 1, 0);  -- S

/*	Untrained Troll - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(145, 2, 1, 0),  -- S
(145, 1, 0, 1),  -- A
(145, 3, 0, 1),  -- G
(145, 1, 0, 1);  -- P

/* Orc Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(140, 69);  -- Animosity (Orc Linemen)

/* Orc Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(141, 69),  -- Animosity (All team-mates)
(141, 37),  -- Pass
(141, 12);  -- Sure Hands

/* Orc Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(142, 69), -- Animosity (All team-mates)
(142, 1);  -- Block

/* Orc Big Un - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(143, 69);  -- Animosity (Orc Big Uns)

/* Goblin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(144, 19),  -- Dodge
(144, 91),  -- Right Stuff
(144, 95);  -- Stunty

/* Untrained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(145, 67),  -- Always Hungry
(145, 82),  -- Loner
(145, 48),  -- Mighty Blow
(145, 88),  -- Projectile Vomit
(145, 89),  -- Really Stupid
(145, 99);  -- Throw Team Mate
/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(14, 1); -- Badlands Brawl