DELETE FROM base_team;

INSERT INTO base_team (id, name, description, tier) VALUES
(1, 'Amazons', 'Strong female warriors.', 1),
(2, 'Black Orc', 'Elite orc warriors with heavy armor and brute strength.', 2),
(3, 'Chaos Chosen', 'Brutal and aggressive elite Chaos warriors.', 2),
(4, 'Chaos Dwarf', 'Stubborn and brutal dwarves allied with Chaos.', 1),
(5, 'Dark Elf', 'Fast and deadly with excellent passing skills.', 1),
(6, 'Dwarf', 'Sturdy and resilient fighters.', 1),
(7, 'Elven Union', 'Agile elves with a focus on passing and speed.', 2),
(8, 'High Elf', 'Graceful and powerful elves with magic affinity.', 1),
(9, 'Humans', 'Versatile and balanced team.', 1),
(10, 'Imperial Nobility', 'Elite human teams with skill and speed.', 1),
(11, 'Lizardmen', 'Strong and ancient reptilian warriors.', 1),
(12, 'Necromantic Horror', 'Undead team with speed and agility options.', 1),
(13, 'Norse', 'Fierce and hardy northern warriors.', 1),
(14, 'Orc', 'Strong and tough with powerful blitzers.', 1),
(15, 'Shambling Undead', 'Hard to kill undead with special skills.', 1),
(16, 'Skavens', 'Fast and tricky, but fragile.', 1),
(17, 'Wood Elf', 'Agile forest dwellers with great speed and precision.', 1);

-- Tier 2 (Strong niche teams)
INSERT INTO base_team (id, name, description, tier) VALUES
(18, 'Bretonnian Knights', 'Noble knights with strong armor and melee skills.', 2),
(19, 'Chaos Chosen', 'Elite warriors of Chaos, strong and aggressive.', 2),
(20, 'Chaos Renegade', 'Disciples of Chaos with diverse skillsets.', 2),
(21, 'Daemons of Khorne', 'Fierce, bloodthirsty daemons with powerful attacks.', 2),
(22, 'Khorne', 'Followers of Khorne, brutal and bloodthirsty.', 2),
(23, 'Gnomes', 'Tiny and tricky players with unique skills.', 2),
(24, 'Nurgle', 'Rotting, disease-infested followers of Chaos.', 2),
(25, 'Old World Aliance', 'Mixed team of different races united.', 2),
(26, 'Slaanesh', 'Followers of the Chaos god Slaanesh, fast and seductive.', 2),
(27, 'Slann', 'Frog-like creatures with unique jumping abilities.', 2),
(28, 'Underworld', 'Mix of Skaven and Goblins, tricky and unpredictable.', 2),
(29, 'Vampires', 'Bloodthirsty undead with powerful abilities.', 2);

-- Tier 3 (Fun / Underdog teams)
INSERT INTO base_team (id, name, description, tier) VALUES
(30, 'Goblins', 'Cheap and tricky players.', 3),
(31, 'Halflings', 'Small and sneaky, hard to injure.', 3),
(32, 'Khemri', 'Ancient undead with mummies and constructs.', 3),
(33, 'Ogres', 'Massive, tough and slow brutes.', 3),
(34, 'Snotlings', 'Small, numerous, chaotic, and fragile.', 3);