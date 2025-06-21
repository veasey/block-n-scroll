/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 10;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(100, 'Imperial Retainer Lineman', 'Standard lineman with Fend', 'standard', 10, 6, 3, 4, 4, 8, 45000, 16),
(101, 'Imperial Thrower', 'Accurate passer with Running Pass', 'standard', 10, 6, 3, 3, 3, 9, 75000, 2),
(102, 'Imperial Noble Blitzer', 'Blitzer with Block and Catch', 'standard', 10, 7, 3, 3, 4, 9, 105000, 4),
(103, 'Imperial Bodyguard', 'Bodyguard with Stand Firm and Wrestle', 'standard', 10, 6, 3, 3, 5, 9, 90000, 4),
(104, 'Ogre', 'Ogre Big Guy', 'standard', 10, 5, 5, 4, 5, 10, 140000, 1);

/* Imperial Retainer Lineman (G primary, AS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(100, 3, 1, 0),  -- G (General)
(100, 2, 0, 1),  -- S (Strength)
(100, 4, 0, 1);  -- A (Agility)

/* Imperial Thrower (GP primary, AS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(101, 3, 1, 0),  -- G
(101, 1, 1, 0),  -- P (Passing)
(101, 2, 0, 1),  -- S
(101, 4, 0, 1);  -- A

/* Imperial Noble Blitzer (AG primary, PS secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(102, 4, 1, 0),  -- A (Agility)
(102, 3, 1, 0),  -- G (General)
(102, 2, 0, 1),  -- S
(102, 1, 0, 1);  -- P

/* Imperial Bodyguard (GS primary, A secondary) */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(103, 3, 1, 0),  -- G
(103, 2, 1, 0),  -- S
(103, 4, 0, 1);  -- A

/* Ogre (S primary, A secondary) */
INSERT INTO base_team_player_skill_category  (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(104, 2, 1, 0),  -- S
(104, 4, 0, 1);  -- A

/* Imperial Retainer Lineman (Fend) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(100, 21);  -- Fend

/* Imperial Thrower (Pass, Running Pass) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(101, 101),  -- Pass
(101, 107);  -- Running Pass

/* Imperial Noble Blitzer (Block, Catch) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(102, 1),  -- Block
(102, 102);  -- Catch

/* Imperial Bodyguard (Stand Firm, Wrestle) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(103, 47),  -- Stand Firm
(103, 13);  -- Wrestle

/* Ogre (Bone Head, Loner (4+), Mighty Blow (+1), Thick Skull, Throw Team Mate) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(104, 63),  -- Bone Head
(104, 95),  -- Loner (4+)
(104, 17),  -- Mighty Blow (+1)
(104, 37),  -- Thick Skull
(104, 56);  -- Throw Team Mate

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(10, 5);  -- Old World Classic
