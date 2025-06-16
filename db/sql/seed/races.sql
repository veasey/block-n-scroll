DELETE FROM base_team;

INSERT INTO base_team (id, name, description, tier, category_race_special_rule_id, category_regional_special_rule_id) VALUES
(1, 'Amazons', 'Strong female warriors.', 1, NULL, 4),
(2, 'Black Orc', 'Elite orc warriors with heavy armor and brute strength.', 2, NULL, 1),
(3, 'Chaos Chosen', 'Brutal and aggressive elite Chaos warriors.', 2, 4, NULL),
(4, 'Chaos Dwarf', 'Stubborn and brutal dwarves allied with Chaos.', 1, 4, 1),
(5, 'Dark Elf', 'Fast and deadly with excellent passing skills.', 1, NULL, 2),
(6, 'Dwarf', 'Sturdy and resilient fighters.', 1, NULL, 8),
(7, 'Elven Union', 'Agile elves with a focus on passing and speed.', 2, NULL, 2),
(8, 'High Elf', 'Graceful and powerful elves with magic affinity.', 1, NULL, 2),
(9, 'Humans', 'Versatile and balanced team.', 1, NULL, 5),
(10, 'Imperial Nobility', 'Elite human teams with skill and speed.', 1, NULL, 5),
(11, 'Lizardmen', 'Strong and ancient reptilian warriors.', 1, NULL, 4),
(12, 'Necromantic Horror', 'Mix of undead and humans.', 1, 3, 6),
(13, 'Norses', 'Fierce and hardy northern warriors.', 1, NULL, 5),
(14, 'Orc', 'Strong and tough with powerful blitzers.', 1, NULL, 1),
(15, 'Shambling Undead', 'Hard to kill undead with special skills.', 1, 3, 6),
(16, 'Skavens', 'Fast and tricky, but fragile.', 1, NULL, 7),
(17, 'Wood Elf', 'Agile forest dwellers with great speed and precision.', 1, NULL, 2);

-- Tier 2 (Strong niche teams)
INSERT INTO base_team (id, name, description, tier, category_race_special_rule_id, category_regional_special_rule_id) VALUES
(18, 'Bretonnian Knights', 'Noble knights with strong armor and melee skills.', 2, NULL, 5),
(19, 'Chaos Chosen', 'Elite warriors of Chaos, strong and aggressive.', 2, 4, NULL),
(20, 'Chaos Renegade', 'Disciples of Chaos with diverse skillsets.', 2, 4, NULL),
(21, 'Daemons of Khorne', 'Fierce, bloodthirsty daemons with powerful attacks.', 2, 4, NULL),
(22, 'Khorne', 'Followers of Khorne, brutal and bloodthirsty.', 2, 4, NULL),
(23, 'Gnomes', 'Tiny and tricky players with unique skills.', 2, 2, 5),
(24, 'Nurgle', 'Rotting, disease-infested followers of Chaos.', 2, 4, NULL),
(25, 'Old World Aliance', 'Mixed team of different races united.', 2, NULL, 5),
(26, 'Slaanesh', 'Followers of the Chaos god Slaanesh, fast and seductive.', 2, 4, NULL),
(27, 'Slann', 'Frog-like creatures with unique jumping abilities.', 2, NULL, 4),
(28, 'Underworld', 'Mix of Skaven and Goblins, tricky and unpredictable.', 2, NULL, 7),
(29, 'Vampires', 'Bloodthirsty undead with powerful abilities.', 2, 3, 6);

-- Tier 3 (Fun / Underdog teams)
INSERT INTO base_team (id, name, description, tier, category_race_special_rule_id, category_regional_special_rule_id) VALUES
(30, 'Goblins', 'Cheap and tricky players.', 3, 2, 1),
(31, 'Halflings', 'Small and sneaky, hard to injure.', 3, 2, 3),
(32, 'Khemri', 'Ancient undead with mummies and constructs.', 3, 3, 6),
(33, 'Ogres', 'Massive, tough and slow brutes.', 3, 2, 1),
(34, 'Snotlings', 'Small, numerous, chaotic, and fragile.', 3, 2, 7);

/* max rerolls */
UPDATE base_team SET max_rerolls = 6 WHERE name = 'Dwarf';