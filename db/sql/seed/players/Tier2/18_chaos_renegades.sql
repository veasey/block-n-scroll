/* reroll cost */
UPDATE base_team SET reroll_cost = 70000 WHERE id = 18;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id) VALUES
(180, 'Renegade Human Linemen', 'Human lineman', 'standard', 18, 6, 3, 3, 4, 9, 50000, 12, NULL),
(181, 'Renegade Human Thrower', 'Basic Thrower', 'standard', 18, 6, 3, 3, 3, 9, 75000, 1, NULL),
(182, 'Renegade Goblin', 'Stunty Option', 'special', 18, 6, 2, 3, 4, 8, 40000, 1, NULL), 
(183, 'Renegade Orc', 'Bit more armour on the line', 'standard', 18, 5, 3, 3, 5, 10, 50000, 1, NULL),
(184, 'Renegade Skaven', 'Bit of speed', 'standard', 18, 7, 3, 3, 4, 8, 50000, 1, NULL),
(185, 'Renegade Dark Elf', 'Agility Option', 'standard', 18, 6, 3, 2, 3, 9, 75000, 1, NULL),
(186, 'Renegade Rat Ogre', 'The strongest big guy option', 'special', 18, 6, 5, 4, NULL, 9, 150000, 1, 2),
(187, 'Renegade Minotaur', 'Big guy for pushing the line', 'special', 18, 5, 5, 4, NULL, 9, 150000, 1, 2),
(188, 'Renegade Troll', 'Big guy for a roat block', 'special', 18, 4, 5, 5, 5, 10, 115000, 1, 2),
(189, 'Renegade Ogre', 'Middle of the road big guy', 'special', 18, 5, 5, 4, 5, 10, 140000, 1, 2);

INSERT INTO base_team_player_exclusive_group (id, name, description, max_allowed) VALUES 
(2, 'Chaos Renegade Big Guys', 'You can have up to 3 of these 4 big guys', 3);

/* Renegade Human Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(180, 1, 1, 0), -- General
(180, 5, 1, 0), -- Mutations
(180, 2, 0, 1), -- Agility
(180, 3, 0, 1); -- Strength

/* Renegade Human Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(181, 1, 1, 0), -- General
(181, 5, 1, 0), -- Mutations
(181, 4, 1, 0), -- Passing
(181, 2, 0, 1), -- Agility
(181, 3, 0, 1); -- Strength

/* Renegade Goblin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(182, 2, 1, 0), -- Agility
(182, 5, 1, 0), -- Mutations
(182, 1, 0, 1), -- General
(182, 4, 0, 1); -- Passing

/* Renegade Orc - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(183, 1, 1, 0), -- General
(183, 5, 1, 0), -- Mutations
(183, 2, 0, 1), -- Agility
(183, 3, 0, 1); -- Strength

/* Renegade Skaven - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(184, 1, 1, 0), -- General
(184, 5, 1, 0), -- Mutations
(184, 2, 0, 1), -- Agility
(184, 3, 0, 1); -- Strength

/* Renegade Dark Elf - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(185, 2, 1, 0), -- Agility
(185, 1, 1, 0), -- General
(185, 5, 1, 0), -- Mutations
(185, 4, 0, 1), -- Passing
(185, 3, 0, 1); -- Strength

/* Renegade Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(186, 3, 1, 0), -- Strength
(186, 2, 1, 0), -- Agility
(186, 1, 1, 0), -- General
(186, 5, 1, 0); -- Mutations

/* Renegade Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(187, 3, 1, 0), -- Strength
(187, 2, 1, 0), -- Agility
(187, 1, 1, 0), -- General
(187, 5, 1, 0); -- Mutations

/* Renegade Minotaur - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(188, 3, 1, 0), -- Strength
(188, 2, 1, 0), -- Agility
(188, 1, 1, 0), -- General
(188, 5, 1, 0); -- Mutations

/* Renegade Rat Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(189, 3, 1, 0), -- Strength
(189, 2, 1, 0), -- Agility
(189, 1, 1, 0), -- General
(189, 5, 1, 0); -- Mutations

/* Renegade Human Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(181, 69), -- Animosity (all team-mates)
(181, 37), -- Pass
(181, 22); -- Safe Pair of Hands

/* Renegade Goblin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(182, 69), -- Animosity (all team-mates)
(182, 19), -- Dodge
(182, 91), -- Right Stuff
(182, 95); -- Stunty

/* Renegade Orc - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(183, 69); -- Animosity (all team-mates)

/* Renegade Skaven - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(184, 69); -- Animosity (all team-mates)

/* Renegade Dark Elf - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(185, 69); -- Animosity (all team-mates)

/* Renegade Rat Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(186, 68), -- Animal Savagery
(186, 5),  -- Frenzy
(186, 82), -- Loner
(186, 48), -- Mighty Blow
(186, 63); -- Frenzy

/* Renegade Minotaur - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(187, 68),  -- Frenzy
(187, 48),  -- Mighty Blow
(187, 54),  -- Thick Skull
(187, 82),  -- Loner
(187, 60),  -- Horns
(187, 103); -- Unchannelled Fury

/* Renegade Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(188, 90), -- Regeneration
(188, 48), -- Mighty Blow
(188, 54), -- Thick Skull
(188, 82), -- Loner
(188, 89), -- Really Stupid
(188, 67), -- Always Hungry
(188, 88); -- Projectile Vomit

/* Renegade Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(189, 48), -- Mighty Blow
(189, 54), -- Thick Skull
(189, 82), -- Loner
(189, 73), -- Bone Head
(189, 99); -- Throw Team-Mate

/* Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(17, 4); -- Favourd Of… (choose either): Undivided, Khorne, Nurgle, Slaanesh, Tzeentch