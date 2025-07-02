INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(290, 'Hopeful', 'Stunty lineman', 'standard', 29, 5, 2, 3, 4, 7, 30000, 16),
(291, 'Hefty', 'Blocker', 'standard', 29, 5, 2, 3, 3, 8, 50000, 2),
(292, 'Catcher', 'Ball Handler', 'standard', 29, 5, 2, 3, 5, 7, 55000, 2),
(293, 'Altern Forest Treeman', 'Big Guy', 'standard', 29, 2, 6, 5, 5, 11, 120000, 2);

/* Hopeful - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(290, 1, 1, 0), -- Agility
(290, 3, 0, 1), -- General
(290, 2, 0, 1); -- Strength

/* Hefty - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(291, 1, 1, 0), -- Agility
(291, 4, 1, 0), -- Passing
(291, 3, 0, 1), -- General
(291, 2, 0, 1); -- Strength

/* Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(292, 1, 1, 0), -- Agility
(292, 3, 0, 1), -- General
(292, 2, 0, 1); -- Strength

/* Altern Forest Treeman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(293, 2, 1, 0), -- Strength
(293, 1, 0, 1), -- Agility
(293, 3, 0, 1), -- General
(293, 4, 0, 1); -- Passing

/* Hopeful - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(290, 19), -- Dodge
(290, 95), -- Stunty
(290, 91); -- Right Stuff

/* Hefty - Starting Skills */
(291, 19), -- Dodge
(291, 95), -- Stunty
(291, 4);  -- Fend

/* Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(292, 19), -- Dodge
(292, 95), -- Stunty
(292, 91), -- Right Stuff
(292, 15), -- Catch
(292, 25); -- Sprint

/* Altern Forest Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(293, 82),  -- Loner
(293, 48),  -- Mighty Blow
(293, 52),  -- Stand Firm
(293, 53),  -- Strong Arm
(293, 98),  -- Take Root
(293, 54),  -- Thick Skull
(293, 99),  -- Throw Team Mate
(293, 100); -- Timmm-ber!

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(29, 3), -- Halfling Thimble Cup
(29, 5); -- Old World Classic
