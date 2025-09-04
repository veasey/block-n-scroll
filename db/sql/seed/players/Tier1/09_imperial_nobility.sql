/* reroll cost */
UPDATE base_team SET reroll_cost = 70000 WHERE id = 9;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(90, 'Imperial Retainer Lineman', 'Standard lineman with Fend', 'standard', 9, 6, 3, 4, 4, 8, 45000, 16),
(91, 'Imperial Thrower', 'Accurate passer with Running Pass', 'standard', 9, 6, 3, 3, 3, 9, 75000, 2),
(92, 'Imperial Noble Blitzer', 'Blitzer with Block and Catch', 'standard', 9, 7, 3, 3, 4, 9, 105000, 4),
(93, 'Imperial Bodyguard', 'Bodyguard with Stand Firm and Wrestle', 'standard', 9, 6, 3, 3, 5, 9, 90000, 4),
(94, 'Ogre', 'Ogre Big Guy', 'standard', 9, 5, 5, 4, 5, 10, 140000, 1);

/* Imperial Retainer Lineman (G primary, AS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(90, 1, 1, 0), -- General
(90, 3, 0, 1), -- Strength
(90, 2, 0, 1); -- Agility

/* Imperial Thrower (GP primary, AS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(91, 1, 1, 0), -- General
(91, 4, 1, 0), -- Passing
(91, 3, 0, 1), -- Strength
(91, 2, 0, 1); -- Agility

/* Imperial Noble Blitzer (AG primary, PS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(92, 2, 1, 0), -- Agility
(92, 1, 1, 0), -- General
(92, 3, 0, 1), -- Strength
(92, 4, 0, 1); -- Passing

/* Imperial Bodyguard (GS primary, A secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(93, 1, 1, 0), -- General
(93, 3, 1, 0), -- Strength
(93, 2, 0, 1); -- Agility

/* Ogre (S primary, A secondary) */
INSERT INTO base_team_player_skill_category  (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(94, 3, 1, 0), -- Strength
(94, 2, 0, 1); -- Agility

/* Imperial Retainer Lineman (Fend) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(90, 4); -- Fend

/* Imperial Thrower (Pass, Running Pass) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(91, 37), -- Passingass
(91, 39); -- Running Pass

/* Imperial Noble Blitzer (Block, Catch) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(92, 1),  -- Block
(92, 15); -- Catch

/* Imperial Bodyguard (Stand Firm, Wrestle) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(93, 52), -- Strengthtand Firm
(93, 14); -- Wrestle

/* Ogre (Bone Head, Loner (4+), Mighty Blow (+1), Thick Skull, Throw Team Mate) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(94, 73), -- Bone Head
(94, 82), -- Loner (4+)
(94, 48), -- Mighty Blow (+1)
(94, 54), -- Thick Skull
(94, 99); -- Throw Team Mate

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(9, 5);  -- Old World Classic
