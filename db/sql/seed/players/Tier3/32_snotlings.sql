INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(320, 'Snotling', 'Stunty lineman', 'standard', 32, 5, 1, 3, 5, 6, 15000, 16),
(321, 'Fungus Flinga', 'Bomber', 'special', 32, 5, 1, 3, 4, 6, 30000, 2),
(322, 'Fun-hoppa', 'Runner', 'special', 32, 6, 1, 3, 5, 6, 20000, 2),
(323, 'Stilty Runna', 'Runner', 'special', 32, 6, 1, 3, 5, 6, 20000, 2),
(324, 'Pump Wagon', 'Big Secret Weapon', 'special', 32, 4, 5, 5, NULL, 9, 105000, 2),
(325, 'Trained Troll', 'Big Guy', 'standard', 32, 4, 5, 5, 5, 10, 115000, 2);

/* Snotling - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(320, 1, 1, 0), -- Agility
(320, 3, 0, 1); -- General

/* Fungus Flinga - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(321, 1, 1, 0), -- Agility
(321, 4, 1, 0), -- Passing
(321, 3, 0, 1); -- General

/* Fun-hoppa - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(322, 1, 1, 0), -- Agility
(322, 3, 0, 1); -- General

/* Stilty Runna - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(323, 1, 1, 0), -- Agility
(323, 3, 0, 1); -- General

/* Pump Wagon - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(324, 2, 1, 0), -- Strength
(324, 1, 0, 1), -- Agility
(324, 3, 0, 1); -- General

/* Trained Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(325, 2, 1, 0), -- Strength
(325, 1, 0, 1), -- Agility
(325, 3, 0, 1), -- General
(325, 4, 0, 1); -- Passing

/* Snotling - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(320, 19),  -- Dodge
(320, 91),  -- Right Stuff
(320, 95),  -- Stunty
(320, 101), -- Titchy
(320, 23),  -- Sidestep
(320, 96);  -- Swarming

/* Fungus Flinga - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(321, 72), -- Bombardier
(321, 19), -- Dodge
(321, 91), -- Right Stuff
(321, 92), -- Secret Weapon
(321, 23), -- Sidestep
(321, 95); -- Stunty

/* Fun-hoppa - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(322, 19), -- Dodge
(322, 91), -- Right Stuff
(322, 87), -- Pogo Stick
(322, 23), -- Sidestep
(322, 95); -- Stunty

/* Stilty Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(323, 19), -- Dodge
(323, 91), -- Right Stuff
(323, 23), -- Sidestep
(323, 25), -- Sprint
(323, 95); -- Stunty

/* Pump Wagon - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(324, 3),  -- Dirty Player
(324, 47), -- Juggernaut
(324, 48), -- Mighty Blow
(324, 89), -- Really Stupid
(324, 92), -- Secret Weapon
(324, 52); -- Stand Firm

/* Trained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(325, 67), -- Always Hungry
(325, 82), -- Loner
(325, 48), -- Mighty Blow
(325, 88), -- Projectile Vomit
(325, 89), -- Really Stupid
(325, 90), -- Regeneration
(325, 99); -- Throw Team Mate

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(32, 1), -- Bribery and Corruption
(32, 2); -- Low cost lineman

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(32, 7); -- Underworld Challenge
