INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(290, 'Goblin', 'Stunty lineman', 'standard', 29, 6, 2, 3, 4, 8, 40000, 12),
(291, 'Bomma', 'Bomber', 'special', 29, 6, 2, 3, 4, 8, 45000, 1),
(292, 'Looney', 'Secret Weapon', 'special', 29, 6, 2, 3, NULL, 8, 40000, 1),
(293, 'Fanatic', 'Secret Weapon', 'special', 29, 3, 7, 3, NULL, 8, 70000, 1),
(294, 'Pogoer', 'Runner', 'special', 29, 7, 2, 3, 5, 8, 75000, 1),
(295, 'Ooligan', 'Interferes with passing', 'special', 29, 6, 2, 3, 6, 8, 65000, 1),
(296, 'Doom Diver', 'Thrown Runner', 'special', 29, 6, 2, 3, 6, 8, 60000, 1),
(297, 'Troll', 'Big Guy', 'standard', 29, 4, 5, 5, 5, 10, 115000, 2);

/* Goblin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(290, 2, 1, 0), -- Agility
(290, 1, 0, 1), -- General
(290, 4, 0, 1), -- Passing
(290, 3, 0, 1); -- Strength

/* Bomma - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(291, 2, 1, 0), -- Agility
(291, 4, 1, 0), -- Passing
(291, 1, 0, 1), -- General
(291, 3, 0, 1); -- Strength

/* Looney - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(292, 2, 1, 0), -- Agility
(292, 1, 0, 1), -- General
(292, 3, 0, 1); -- Strength

/* Fanatic - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(293, 3, 1, 0), -- Strength
(293, 1, 0, 1), -- General
(293, 2, 0, 1); -- Agility

/* Pogoer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(294, 2, 1, 0), -- Agility
(294, 1, 0, 1), -- General
(294, 4, 0, 1), -- Passing
(294, 3, 0, 1); -- Strength

/* Ooligan - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(295, 2, 1, 0), -- Agility
(295, 1, 0, 1), -- General
(295, 4, 0, 1), -- Passing
(295, 3, 0, 1); -- Strength

/* Doom Diver - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(296, 2, 1, 0), -- Agility
(296, 1, 0, 1), -- General
(296, 4, 0, 1), -- Passing
(296, 3, 0, 1); -- Strength

/* Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(297, 3, 1, 0), -- Strength
(297, 1, 0, 1), -- General
(297, 2, 0, 1), -- Agility
(297, 4, 0, 1); -- Passing

/* Goblin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(290, 19), -- Dodge
(290, 91), -- Right Stuff
(290, 95); -- Stunty

/* Bomma - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(291, 19), -- Dodge
(291, 95), -- Stunty
(291, 92), -- Secret Weapon
(291, 72); -- Bombardier

/* Looney - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(292, 19), -- Dodge
(292, 95), -- Stunty
(292, 92), -- Secret Weapon
(292, 75); -- Chainsaw

/* Fanatic - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(293, 95), -- Stunty
(293, 84), -- No Hands
(293, 92), -- Secret Weapon
(293, 70); -- Ball & Chain

/* Pogoer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(294, 19), -- Dodge
(294, 95), -- Stunty
(294, 87); -- Pogo Stick

/* Doom Diver - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(296, 95), -- Stunty
(296, 91), -- Right Stuff
(296, 97); -- Swoop

/* Trained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(297, 67), -- Always Hungry
(297, 82), -- Loner
(297, 48), -- Mighty Blow
(297, 88), -- Projectile Vomit
(297, 89), -- Really Stupid
(297, 90), -- Regeneration
(297, 99); -- Throw Team Mate

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(29, 1); -- Bribery and Corruption

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(29, 1), -- Badlands Brawl
(29, 7); -- Underworld Challenge
