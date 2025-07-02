INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(300, 'Hopeful', 'Stunty lineman', 'standard', 30, 5, 2, 3, 4, 7, 30000, 16),
(301, 'Hefty', 'Blocker', 'standard', 30, 5, 2, 3, 3, 8, 50000, 2),
(302, 'Catcher', 'Ball Handler', 'standard', 30, 5, 2, 3, 5, 7, 55000, 2),
(303, 'Altern Forest Treeman', 'Big Guy', 'standard', 30, 2, 6, 5, 5, 11, 120000, 2);

/* Hopeful - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(300, 1, 1, 0), -- Agility
(300, 3, 0, 1), -- General
(300, 2, 0, 1); -- Strength

/* Hefty - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(301, 1, 1, 0), -- Agility
(301, 4, 1, 0), -- Passing
(301, 3, 0, 1), -- General
(301, 2, 0, 1); -- Strength

/* Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(302, 1, 1, 0), -- Agility
(302, 3, 0, 1), -- General
(302, 2, 0, 1); -- Strength

/* Altern Forest Treeman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(303, 2, 1, 0), -- Strength
(303, 1, 0, 1), -- Agility
(303, 3, 0, 1), -- General
(303, 4, 0, 1); -- Passing

/* Hopeful - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(300, 19), -- Dodge
(300, 95), -- Stunty
(300, 91); -- Right Stuff

/* Hefty - Starting Skills */
(301, 19), -- Dodge
(301, 95), -- Stunty
(301, 4);  -- Fend

/* Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(302, 19), -- Dodge
(302, 95), -- Stunty
(302, 91), -- Right Stuff
(302, 15), -- Catch
(302, 25); -- Sprint

/* Altern Forest Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(303, 82),  -- Loner
(303, 48),  -- Mighty Blow
(303, 52),  -- Stand Firm
(303, 53),  -- Strong Arm
(303, 98),  -- Take Root
(303, 54),  -- Thick Skull
(303, 99),  -- Throw Team Mate
(303, 100); -- Timmm-ber!

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(30, 3), -- Halfling Thimble Cup
(30, 5); -- Old World Classic
