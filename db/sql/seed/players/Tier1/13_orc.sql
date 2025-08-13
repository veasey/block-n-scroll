INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(130, 'Orc Linemen', 'Cheap and high armour linemen', 'standard', 13, 5, 3, 3, 4, 10, 50000, 16),
(131, 'Orc Thrower', 'Vulnerable Orc who can pick up the ball', 'standard', 13, 5, 3, 3, 3, 9, 65000, 2),
(132, 'Orc Blitzer', 'Blitzer', 'standard', 13, 6, 3, 3, 4, 10, 80000, 4),
(133, 'Orc Big Un', 'Strength 4 Blocker', 'standard', 13, 5, 4, 4, NULL, 10, 90000, 4),
(134, 'Goblin', 'Stunty', 'standard', 13, 6, 2, 3, 4, 8, 40000, 4),
(135, 'Untrained Troll', 'Big Guy', 'standard', 13, 4, 5, 5, 5, 10, 115000, 1);

/* Orc Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(130, 3, 1, 0), -- General
(130, 4, 0, 1), -- Agility
(130, 2, 0, 1); -- Strength

/* Orc Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(131, 3, 1, 0), -- General
(131, 1, 1, 0), -- Passing
(131, 4, 0, 1), -- Agility
(131, 2, 0, 1); -- Strength

/* 	Orc Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(132, 3, 1, 0), -- General
(132, 2, 1, 0), -- Strength
(132, 4, 0, 1), -- Agility
(132, 1, 0, 1); -- Passing

/* Orc Big Un - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(133, 3, 1, 0), -- General
(133, 2, 1, 0), -- Strength
(133, 1, 0, 1); -- Agility

/* Goblin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(134, 1, 0, 1), -- Agility
(134, 3, 1, 0), -- General
(134, 2, 1, 0); -- Strength

/*	Untrained Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(135, 2, 1, 0), -- Strength
(135, 1, 0, 1), -- Agility
(135, 3, 0, 1), -- General
(135, 4, 0, 1); -- Passing

/* Orc Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(130, 69); -- Animosity (Orc Linemen)

/* Orc Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(131, 69), -- Animosity (All team-mates)
(131, 37), -- Pass
(131, 12); -- Sure Hands

/* Orc Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(132, 69), -- Animosity (All team-mates)
(132, 1);  -- Block

/* Orc Big Un - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(133, 69); -- Animosity (Orc Big Uns)

/* Goblin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(134, 19), -- Dodge
(134, 91), -- Right Stuff
(134, 95); -- Stunty

/* Untrained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(135, 67), -- Always Hungry
(135, 82), -- Loner
(135, 48), -- Mighty Blow
(135, 88), -- Projectile Vomit
(135, 89), -- Really Stupid
(135, 99); -- Throw Team Mate

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(13, 1); -- Badlands Brawl