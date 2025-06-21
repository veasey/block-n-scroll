/* Human Team: Reroll Cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 9;

/* Human Team Players */
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(90, 'Lineman', 'Standard Human lineman', 'standard', 9, 6, 3, 3, 4, 9, 50000, 16),
(91, 'Thrower', 'Accurate passer with Sure Hands', 'standard', 9, 6, 3, 3, 2, 9, 80000, 2),
(92, 'Catcher', 'Fast receiver with Catch and Dodge', 'standard', 9, 8, 2, 3, 5, 8, 65000, 4),
(93, 'Blitzer', 'Block specialist with good mobility', 'standard', 9, 7, 3, 3, 4, 9, 85000, 4),
(94, 'Halfling', 'Small agile player with Stunty', 'standard', 9, 5, 2, 3, 4, 7, 30000, 2),
(95, 'Ogre', 'Massive Strength with Bone Head and Throw Team Mate', 'standard', 9, 5, 5, 4, 5, 10, 140000, 1);

/* Lineman Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(90, 1, 1, 0),  -- GEN
(90, 2, 0, 1),  -- AG
(90, 3, 0, 1);  -- STR

/* Thrower Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(91, 1, 1, 0),  -- GEN
(91, 4, 1, 0),  -- PAS
(91, 2, 0, 1),  -- AG
(91, 3, 0, 1); -- STR

/* Catcher Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(92, 2, 1, 0),  -- AG
(92, 1, 1, 0),  -- GEN
(92, 4, 0, 1),  -- PAS
(92, 3, 0, 1); -- STR

/* Blitzer Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(93, 1, 1, 0),  -- GEN
(93, 3, 1, 0),  -- STR
(93, 2, 0, 1), -- AG
(93, 4, 0, 1);  -- PAS

/* Halfling Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(94, 2, 1, 0),  -- AG
(94, 1, 0, 1),  -- GEN
(94, 3, 0, 1); -- STR

/* Ogre Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(95, 3, 1, 0),  -- STR
(95, 2, 0, 1), -- AG
(95, 1, 0, 1);  -- GEN

/* Thrower Starting Skills (Pass, Sure Hands) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(91, 30), -- Sure Hands
(91, 37); -- Pass

/* Catcher Starting Skills (Catch, Dodge) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(92, 12), -- Catch
(92, 11); -- Dodge

/* Blitzer Starting Skills (Block) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(93, 1); -- Block

/* Halfling Starting Skills (Dodge, Right Stuff, Stunty) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(94, 11), -- Dodge
(94, 20), -- Right Stuff
(94, 44); -- Stunty

/* Ogre Starting Skills (Bone Head, Loner 4+, Mighty Blow +1, Thick Skull, Throw Team Mate) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(95, 53), -- Bone Head
(95, 42), -- Loner (4+)
(95, 2),  -- Mighty Blow (+1)
(95, 9),  -- Thick Skull
(95, 46); -- Throw Team Mate

/* Add Team to Region */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(9, 5); -- Old World Classic
