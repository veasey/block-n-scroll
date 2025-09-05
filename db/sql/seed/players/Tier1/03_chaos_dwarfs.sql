/* reroll cost */
UPDATE base_team SET reroll_cost = 70000 WHERE id = 3;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id) VALUES
(30, 'Hobgoblin', 'Sneaky and expendable slaves for the Chaos Dwarfs.', 'standard', 3, 6, 3, 3, 4, 8, 40000, 16, NULL),
(31, 'Sneaky Stabba', 'Rogue-like hobgoblin with a knife.', 'special', 3, 6, 3, 3, 5, 8, 70000, 2, NULL),
(32, 'Chaos Dwarf Blocker', 'Stubborn and tough core of the team.', 'standard', 3, 4, 3, 4, 6, 10, 70000, 4, NULL),
(33, 'FlameSmith', 'An alternative blocker with unique abilities', 'special', 3, 5, 3, 4, 6, 10, 80000, 2, NULL),
(34, 'Bull Centaur', 'Fast, powerful and resilient hybrid.', 'special', 3, 6, 4, 4, 6, 10, 130000, 2, NULL),
(35, 'Enslaved Minotaur', 'Feral big guy under Chaos Dwarf control.', 'special', 3, 5, 5, 4, NULL, 9, 150000, 1, 2);

/* Hobgoblin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(30, 1, 1, 0), -- General
(30, 2, 0, 1), -- Strength
(30, 3, 0, 1); -- Agility

/* Sneaky Stabba - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(31, 1, 1, 0), -- General
(31, 2, 0, 1), -- Strength
(31, 3, 0, 1); -- Agility

/* Chaos Dwarf Blocker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(32, 1, 1, 0), -- General
(32, 3, 1, 0), -- Strength
(32, 2, 0, 1), -- Agility
(32, 5, 0, 1); -- Mutations

/* Flame Smith - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(33, 1, 1, 0), -- General
(33, 3, 1, 0), -- Strength
(33, 2, 0, 1), -- Agility
(33, 5, 0, 1); -- Mutations

/* Bull Centaur - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(34, 1, 1, 0), -- General
(34, 3, 1, 0), -- Strength
(34, 2, 0, 1); -- Agility

/* Enslaved Minotaur - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(35, 3, 1, 0), -- Strength
(35, 1, 0, 1), -- General
(35, 2, 0, 1), -- Agility
(35, 5, 0, 1); -- Mutations

/* Sneaky Stabba - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(31, 10), -- Shadowing
(31, 93); -- Stab

/* Chaos Dwarf Blocker - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(32, 1),  -- Block
(32, 13), -- Tackle
(32, 54); -- Thick Skull

/* Flame Smith - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(33, 43), -- Brawler
(33, 74), -- Breathe Fire
(33, 57), -- Disturbing Presence
(33, 54); -- Thick Skull

/* Bull Centaur - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(34, 25), -- Sprint
(34, 26), -- Sure Feet
(34, 54); -- Thick Skull

/* Enslaved Minotaur - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(35, 68), -- Animal Savagery
(35, 5),  -- Frenzy
(35, 60), -- Horns
(35, 82), -- Loner (4+)
(35, 48), -- Mighty Blow (+1)
(35, 54); -- Thick Skull

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(3, 1), -- badlands brawl
(3, 8); -- world's edge

/* Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(3, 4); -- favoured of