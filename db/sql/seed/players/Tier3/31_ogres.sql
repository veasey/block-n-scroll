/* Reroll Cost */
update base_team SET reroll_cost = 70000 WHERE id = 31;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(310, 'Gnoblar', 'Titchy lineman', 'standard', 31, 5, 1, 3, 5, 6, 15000, 16),
(311, 'Runt Punter', 'Stunty Thrower', 'special', 31, 5, 5, 4, 4, 10, 145000, 1),
(312, 'Ogre', 'Big Guy', 'standard', 31, 5, 5, 4, 5, 10, 140000, 5);

/* Gnoblar - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(310, 2, 1, 0), -- Agility
(310, 1, 0, 1); -- General

/* Runt Punter - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(311, 4, 1, 0), -- Passing
(311, 3, 1, 0), -- Strength
(311, 2, 0, 1), -- Agility
(311, 1, 0, 1); -- General

/* Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(312, 3, 1, 0), -- Strength
(312, 2, 0, 1), -- Agility
(312, 1, 0, 1), -- General
(312, 4, 0, 1); -- Passing

/* Gnoblar - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(310, 19),  -- Dodge
(310, 91),  -- Right Stuff
(310, 95),  -- Stunty
(310, 101), -- Titchy
(310, 23);  -- Sidestep

/* Runt Punter - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(311, 73), -- Bone Head
(311, 81), -- Kick Team MAte
(311, 48), -- Mighty Blow (+1)
(311, 54); -- Thick Skull

/* Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(312, 73), -- Bone Head
(312, 48), -- Mighty Blow (+1)
(312, 54), -- Thick Skull
(312, 99); -- Throw Team Mate

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(31, 2); -- Low cost lineman

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(31, 1), -- Badlands Brawl
(31, 5); -- Old World Classic
