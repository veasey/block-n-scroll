/* Reroll Cost */
update base_team SET reroll_cost = 70000 WHERE id = 23;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id) VALUES
(230, 'Old World Human Linemen', 'Lineman', 'standard', 23, 6, 3, 3, 4, 9, 50000, 12, NULL),
(231, 'Old World Human Thrower', 'Thrower', 'standard', 23, 6, 3, 3, 3, 9, 80000, 1, NULL),
(232, 'Old World Human Catcher', 'Catcher', 'standard', 23, 8, 2, 3, 5, 8, 65000, 1, NULL),
(233, 'Old World Human Blitzer', 'Blitzer', 'standard', 23, 7, 3, 3, 4, 9, 90000, 1, NULL),
(234, 'Old World Dwarf Blocker', 'Blocker', 'standard', 23, 4, 3, 4, 5, 10, 75000, 2, NULL),
(235, 'Old World Dwarf Runner', 'Runner', 'standard', 23, 6, 3, 3, 4, 9, 85000, 1, NULL),
(236, 'Old World Dwarf Blitzer', 'Blitzer', 'standard', 23, 5, 3, 3, 4, 10, 80000, 1, NULL),
(237, 'Old World Troll Slayer', 'Brawler', 'special', 23, 5, 3, 4, NULL, 9, 95000, 1, NULL),
(238, 'Old World Halfing', 'Stunty', 'standard', 23, 5, 2, 3, 4, 7, 30000, 2, NULL),
(239, 'Ogre', 'Big Guy', 'standard', 23, 5, 5, 4, 5, 10, 140000, 1, 3),
(240, 'Altern Forest Treeman', 'Big Guy', 'standard', 23, 2, 6, 5, 5, 11, 120000, 1, 3);

INSERT INTO base_team_player_exclusive_group (id, name, description) VALUES
(3, 'Old World Alliance', 'Ogre or Tree');

/* Old World Human Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(230, 1, 1, 0), -- General
(230, 2, 0, 1), -- Agility
(230, 3, 0, 1); -- Strength

/* Old World Human Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(231, 1, 1, 0), -- General
(231, 4, 1, 0), -- Passing
(231, 2, 0, 1), -- Agility
(231, 3, 0, 1); -- Strength

/* Old World Human Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(232, 2, 0, 1), -- Agility
(232, 1, 1, 0), -- General
(232, 3, 1, 0); -- Strength

/* Old World Human Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(233, 1, 1, 0), -- General
(233, 3, 1, 0), -- Strength
(233, 2, 0, 1); -- Agility

/* Old World Dwarf Blocker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(234, 1, 1, 0), -- General
(234, 3, 1, 0), -- Strength
(234, 2, 0, 1); -- Agility

/* Old World Dwarf Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(235, 1, 1, 0), -- General
(235, 4, 1, 0), -- Passing
(235, 2, 0, 1), -- Agility
(235, 3, 0, 1); -- Strength

/* Old World Dwarf Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(236, 1, 1, 0), -- General
(236, 3, 1, 0), -- Strength
(236, 2, 0, 1); -- Agility

/* Old World Dwarf Troll Slayer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(237, 1, 1, 0), -- General
(237, 3, 1, 0), -- Strength
(237, 2, 0, 1); -- Agility

/* Old World Halfing - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(238, 2, 1, 0), -- Agility
(238, 1, 0, 1), -- General
(238, 3, 0, 1); -- Strength

/* Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(239, 3, 1, 0), -- Strength
(239, 2, 0, 1), -- Agility
(239, 1, 0, 1); -- General

/* Altern Forest Treeman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(240, 3, 1, 0), -- Strength
(240, 2, 0, 1), -- Agility
(240, 1, 0, 1), -- General
(240, 4, 0, 1); -- Passing

/* Old World Human Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(231, 69), -- Animosity (Dwarf and Halfling)
(231, 37), -- Pass
(231, 12); -- Sure Hands

/* Old World Human Catcher - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(232, 69), -- Animosity (Dwarf and Halfling)
(232, 15), -- Catch
(232, 19); -- Dodge

/* Old World Human Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(233, 69), -- Animosity (Dwarf and Halfling)
(233, 1);  -- Block

/* Old World Dwarf Blocker - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(234, 42), -- Arm Bar
(234, 43), -- Brawler
(234, 82), -- Loner
(234, 54); -- Thick Skull

/* Old World Dwarf Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(235, 82), -- Loner
(235, 12), -- Sure Hands
(235, 54); -- Thick Skull

/* Old World Dwarf Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(236, 82), -- Loner
(236, 1),  -- Block
(236, 54); -- Thick Skull

/* Old World Dwarf Troll Slayer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(237, 1),  -- Block
(237, 2),  -- Dauntless
(237, 5),  -- Frenzy
(237, 82), -- Loner
(237, 54); -- Thick Skull

/* Old World Halfing - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(238, 69), -- Animosity (Dwarf and Halfling)
(238, 19), -- Dodge
(238, 91), -- Right Stuff
(238, 95); -- Stunty

/* Ogre Starting Skills (Bone Head, Loner 4+, Mighty Blow +1, Thick Skull, Throw Team Mate) */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(239, 73), -- Bone Head
(239, 82), -- Loner (4+)
(239, 48), -- Mighty Blow (+1)
(239, 54), -- Thick Skull
(239, 99); -- Throw Team Mate

/* Altern Forest Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(240, 82),  -- Loner
(240, 48),  -- Mighty Blow
(240, 52),  -- Stand Firm
(240, 53),  -- Strong Arm
(240, 98),  -- Take Root
(240, 54),  -- Thick Skull
(240, 99),  -- Throw Team Mate
(240, 100); -- Timm-ber!

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(23, 5); -- Old World Classic