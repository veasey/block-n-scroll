/* Reroll Cost */
update base_team SET reroll_cost = 70 WHERE id = 26;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(260, 'Underworld Goblin Linemen', 'Stunty Lineman', 'standard', 26, 6, 2, 3, 4, 8, 40000, 12, NULL),
(261, 'Underworld Snotling', 'Stuntier Stunties', 'special', 26, 5, 1, 3, 5, 6, 15000, 6, NULL),
(262, 'Skaven Clanrat', 'Lineman', 'standard', 26, 7, 3, 3, 4, 8, 50000, 3, NULL),
(263, 'Skaven Thrower', 'Thrower', 'standard', 26, 7, 3, 3, 2, 8, 85000, 1, NULL),
(264, 'Gutter Runner', 'Runner', 'standard', 26, 9, 2, 2, 4, 8, 85000, 1, NULL),
(265, 'Skaven Blitzer', 'Blitzer', 'standard', 26, 7, 3, 3, 5, 9, 90000, 1, NULL),
(266, 'Underworld Troll', 'Big Guy', 'standard', 26, 4, 5, 5, 5, 10, 115000, 1, 4),
(267, 'Mutant Rat Ogre', 'Big Guy', 'standard', 26, 6, 5, 4, NULL, 9, 150000, 1, 4);

INSERT INTO base_team_player_exclusive_group (id, name, description) VALUES
(4, 'Underworld', 'Rat Ogre or Troll');

/* Underworld Goblin Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(260, 1, 0, 1), -- Agility
(260, 5, 1, 0), -- Mutations
(260, 3, 1, 0), -- General
(260, 2, 1, 0); -- Strength

/* Underworld Snotling - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(261, 1, 0, 1), -- Agility
(261, 5, 1, 0), -- Mutations
(261, 3, 1, 0); -- General

/* Skaven Clanrat - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(262, 3, 1, 0), -- General
(262, 5, 1, 0), -- Mutations
(262, 4, 0, 1), -- Agility
(262, 2, 0, 1); -- Strength

/* Skaven Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(263, 3, 1, 0), -- General
(263, 5, 1, 0), -- Mutations
(263, 1, 1, 0), -- Passing
(263, 4, 0, 1), -- Agility
(263, 2, 0, 1); -- Strength

/* Gutter Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES  
(264, 4, 1, 0), -- Agility
(264, 3, 1, 0), -- General
(264, 5, 1, 0), -- Mutations
(264, 1, 0, 1), -- Passing
(264, 2, 0, 1); -- Strength

/* Skaven Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(265, 3, 1, 0), -- General
(265, 5, 1, 0), -- Mutations
(265, 2, 1, 0), -- Strength
(265, 4, 0, 1), -- Agility
(265, 1, 0, 1); -- Passing

/* Underworld Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(266, 5, 1, 0), -- Mutations
(266, 2, 1, 0), -- Strength
(266, 4, 0, 1), -- Agility
(266, 3, 0, 1), -- General
(266, 1, 0, 1); -- Passing

/* Mutant Rat Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(267, 5, 1, 0), -- Mutations
(267, 2, 1, 0), -- Strength
(267, 4, 0, 1), -- Agility
(267, 3, 0, 1); -- General 

/* Underworld Goblin Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(260, 19), -- Dodge
(260, 95), -- Stunty
(260, 91); -- Right Stuff

/* Underworld Snotling - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(261, 19),  -- Dodge
(261, 95),  -- Stunty
(261, 23),  -- Sidestep
(261, 101), -- Titchy
(261, 91);  -- Right Stuff

/* Skaven Clanrat - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(262, 69); -- Animosity (Goblins)

/* Skaven Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(263, 69), -- Animosity (Goblins)
(263, 37), -- Pass
(263, 12); -- Sure Hands

/* Gutter Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(264, 69), -- Animosity (Goblins)
(264, 19); -- Dodge

/* 	Skaven Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(265, 69), -- Animosity (Goblins)
(265, 1);  -- Block

/* Underworld Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(266, 67), -- Always Hungry
(266, 82), -- Loner
(266, 48), -- Mighty Blow
(266, 88), -- Projectile Vomit
(266, 89), -- Really Stupid
(266, 90), -- Regeneration
(266, 99); -- Throw Team Mate

/* Mutant Rat Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(267, 68), -- Animal Savagery
(267, 5),  -- Frenzy
(267, 82), -- Loner
(267, 48), -- Mighty Blow
(267, 63); -- Prehensile Tail

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(26, 1); -- Bribery and Corruption

/* Add Team to Region */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(26, 7); -- Underworld Challenge