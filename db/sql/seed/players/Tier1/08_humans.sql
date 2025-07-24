/* Human Team: Reroll Cost */
UPDATE base_team SET reroll_cost = 50000 WHERE id = 8;

/* Human Team Players */
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(80, 'Lineman', 'Standard Human lineman', 'standard', 8, 6, 3, 3, 4, 9, 50000, 16),
(81, 'Thrower', 'Accurate passer with Sure Hands', 'standard', 8, 6, 3, 3, 2, 9, 80000, 2),
(82, 'Catcher', 'Fast receiver with Catch and Dodge', 'standard', 8, 8, 2, 3, 5, 8, 65000, 4),
(83, 'Blitzer', 'Block specialist with good mobility', 'standard', 8, 7, 3, 3, 4, 9, 85000, 4),
(84, 'Halfling', 'Small agile player with Stunty', 'standard', 8, 5, 2, 3, 4, 7, 30000, 2),
(85, 'Ogre', 'Massive Strength with Bone Head and Throw Team Mate', 'standard', 8, 5, 5, 4, 5, 10, 140000, 1);

/* Lineman Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(80, 1, 1, 0), -- Generaleral
(80, 2, 0, 1), -- Agility
(80, 3, 0, 1); -- Strength

/* Thrower Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(81, 1, 1, 0), -- General
(81, 4, 1, 0), -- Passing
(81, 2, 0, 1), -- Agility
(81, 3, 0, 1); -- Strength

/* Catcher Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(82, 2, 1, 0), -- Agility
(82, 1, 1, 0), -- General
(82, 4, 0, 1), -- Passing
(82, 3, 0, 1); -- Strength

/* Blitzer Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(83, 1, 1, 0), -- General
(83, 3, 1, 0), -- Strength
(83, 2, 0, 1), -- Agility
(83, 4, 0, 1); -- Passing

/* Halfling Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(84, 2, 1, 0), -- Agility
(84, 1, 0, 1), -- General
(84, 3, 0, 1); -- Strength

/* Ogre Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(85, 3, 1, 0), -- Strength
(85, 2, 0, 1), -- Agility
(85, 1, 0, 1); -- General

/* Thrower Starting Skills (Pass, Sure Hands) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(81, 12), -- Sure Hands
(81, 37); -- Pass

/* Catcher Starting Skills (Catch, Dodge) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(82, 16), -- Catch
(82, 19); -- Dodge

/* Blitzer Starting Skills (Block) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(83, 1); -- Block

/* Halfling Starting Skills (Dodge, Right Stuff, Stunty) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(84, 19), -- Dodge
(84, 91), -- Right Stuff
(84, 95); -- Stunty

/* Ogre Starting Skills (Bone Head, Loner 4+, Mighty Blow +1, Thick Skull, Throw Team Mate) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(85, 73), -- Bone Head
(85, 82), -- Loner (4+)
(85, 48), -- Mighty Blow (+1)
(85, 54), -- Thick Skull
(85, 99); -- Throw Team Mate

/* Add Team to Region */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(8, 5); -- Old World Classic
