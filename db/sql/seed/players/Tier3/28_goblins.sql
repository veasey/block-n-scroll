INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(280, 'Goblin', 'Stunty lineman', 'standard', 28, 6, 2, 3, 4, 8, 40000, 12),
(281, 'Bomma', 'Bomber', 'special', 28, 6, 2, 3, 4, 8, 45000, 1),
(282, 'Looney', 'Secret Weapon', 'special', 28, 6, 2, 3, NULL, 8, 40000, 1),
(283, 'Fanatic', 'Secret Weapon', 'special', 28, 3, 7, 3, NULL, 8, 70000, 1),
(284, 'Pogoer', 'Runner', 'special', 28, 7, 2, 3, 5, 8, 75000, 1),
(285, 'Ooligan', 'Interferes with passing', 'special', 28, 6, 2, 3, 6, 8, 65000, 1),
(286, 'Doom Diver', 'Thrown Runner', 'special', 28, 6, 2, 3, 6, 8, 60000, 1),
(287, 'Troll', 'Big Guy', 'standard', 28, 4, 5, 5, 5, 10, 115000, 2);

/* Goblin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(280, 1, 1, 0), -- Agility
(280, 3, 0, 1), -- General
(280, 4, 0, 1), -- Passing
(280, 2, 0, 1); -- Strength

/* Bomma - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(281, 1, 1, 0), -- Agility
(281, 4, 1, 0), -- Passing
(281, 3, 0, 1), -- General
(281, 2, 0, 1); -- Strength

/* Looney - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(282, 1, 1, 0), -- Agility
(282, 3, 0, 1), -- General
(282, 2, 0, 1); -- Strength

/* Fanatic - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(283, 2, 1, 0), -- Strength
(283, 3, 0, 1), -- General
(283, 1, 0, 1); -- Agility

/* Pogoer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES  
(284, 1, 1, 0), -- Agility
(284, 3, 0, 1), -- General
(284, 4, 0, 1), -- Passing
(284, 2, 0, 1); -- Strength

/* Ooligan - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES  
(285, 1, 1, 0), -- Agility
(285, 3, 0, 1), -- General
(285, 4, 0, 1), -- Passing
(285, 2, 0, 1); -- Strength

/* Doom Diver - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES  
(286, 1, 1, 0), -- Agility
(286, 3, 0, 1), -- General
(286, 4, 0, 1), -- Passing
(286, 2, 0, 1); -- Strength

/* Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES
(287, 2, 1, 0), -- Strength
(287, 3, 0, 1), -- General
(287, 1, 0, 1), -- Agility
(287, 4, 0, 1); -- Passing

/* Goblin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(280, 19), -- Dodge
(280, 91), -- Right Stuff
(280, 95); -- Stunty

/* Bomma - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(281, 19), -- Dodge
(281, 95), -- Stunty
(281, 92), -- Secret Weapon
(281, 72); -- Bombardier

/* Looney - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(282, 19), -- Dodge
(282, 95), -- Stunty
(282, 92), -- Secret Weapon
(282, 75); -- Chainsaw

/* Fanatic - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(283, 95), -- Stunty
(283, 84), -- No Hands
(283, 92), -- Secret Weapon
(283, 70); -- Ball & Chain

/* Pogoer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES   
(284, 19), -- Dodge
(284, 95), -- Stunty
(284, 87); -- Pogo Stick

/* Doom Diver - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(286, 95), -- Stunty
(286, 91), -- Right Stuff
(286, 97); -- Swoop

/* Trained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(287, 67), -- Always Hungry
(287, 82), -- Loner
(287, 48), -- Mighty Blow
(287, 88), -- Projectile Vomit
(287, 89), -- Really Stupid
(287, 90); -- Regeneration
(287, 99); -- Throw Team Mate

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(28, 1); -- Bribery and Corruption

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(28, 1), -- Badlands Brawl
(26, 7); -- Underworld Challenge
