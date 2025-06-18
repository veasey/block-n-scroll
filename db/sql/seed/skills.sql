DELETE FROM skill;
DELETE FROM skill_category;

INSERT INTO skill_category (id, name, description) VALUES
(1, 'General', 'General skills and intelligence-based actions.'),
(2, 'Agility', 'Skills that improve dodging, catching, and movement agility.'),
(3, 'Strength', 'Skills that enhance physical strength and blocking capabilities.'),
(4, 'Passing', 'Skills that improve passing and ball handling.'),
(5, 'Mutations', 'Special skills related to mutations and unique traits.');

INSERT INTO skill (id, name, description, type, category) VALUES
-- Strength (STR) Skills
(1, 'Block', 'The player is not knocked down on a Both Down result.', 'normal', 'STR'),
(2, 'Mighty Blow', 'Adds +1 to either the Armour or Injury roll when the player knocks down an opponent.', 'normal', 'STR'),
(3, 'Grab', 'Cancels Side Step and allows placing the opponent in any adjacent square on a push.', 'normal', 'STR'),
(4, 'Tackle', 'Cancels Dodge on Block and prevents Dodge rerolls.', 'normal', 'STR'),
(5, 'Claw', 'Opponent’s Armour value is considered as 8+ for Injury rolls.', 'normal', 'STR'),
(6, 'Horns', 'Adds +1 Strength when making a Blitz action.', 'normal', 'STR'),
(7, 'Stand Firm', 'Player is not pushed back on a Block unless knocked down.', 'normal', 'STR'),
(8, 'Juggernaut', 'On a Blitz, treats Both Down and Push as Push and negates Stand Firm and Wrestle.', 'normal', 'STR'),
(9, 'Thick Skull', 'Injury rolls of 9 become a Stunned result instead of KO.', 'normal', 'STR'),
(10, 'Wrestle', 'Both players go prone on a Both Down, but neither is considered knocked down.', 'normal', 'GEN'),

-- Agility (AG) Skills
(11, 'Dodge', 'Allows rerolling failed Dodge rolls and cancels Tackle’s effects unless negated.', 'normal', 'AG'),
(12, 'Catch', 'Reroll failed catch, interception, or bouncing ball attempts.', 'normal', 'AG'),
(13, 'Leap', 'Allows jumping into any adjacent square; uses Agility roll.', 'normal', 'AG'),
(14, 'Sprint', 'Allows attempting up to 3 GFI rolls instead of 2.', 'normal', 'AG'),
(15, 'Diving Catch', 'Adds +1 to catch rolls for accurate passes and allows catching in adjacent squares.', 'normal', 'AG'),
(16, 'Fend', 'Prevents opponent from following up when they block you.', 'normal', 'GEN'),
(17, 'Jump Up', 'Stand up without spending Movement and can Block from prone with AG roll.', 'normal', 'AG'),
(18, 'Side Step', 'Choose any adjacent square on push instead of being pushed back.', 'normal', 'AG'),
(19, 'Sure Feet', 'Reroll one failed GFI per turn.', 'normal', 'AG'),
(20, 'Right Stuff', 'Allows being thrown by a team-mate with Throw Team-Mate.', 'trait', 'MUT'),

-- Mutation (MUT) Skills
(21, 'Tentacles', 'Opponent must make a Strength test to dodge away from the player.', 'normal', 'MUT'),
(22, 'Extra Arms', '+1 to pick up, catch, or intercept the ball.', 'normal', 'MUT'),
(23, 'Prehensile Tail', '-1 to opponents’ dodge rolls when moving away.', 'normal', 'MUT'),
(24, 'Two Heads', '+1 to Dodge rolls.', 'normal', 'MUT'),
(25, 'Disturbing Presence', '-1 to pass, catch, or intercept rolls within 3 squares.', 'normal', 'MUT'),
(26, 'Hypnotic Gaze', 'AG test to remove opponent’s tackle zones for a turn.', 'normal', 'MUT'),
(27, 'Foul Appearance', 'Opponent must roll 2+ to block this player.', 'normal', 'MUT'),
(28, 'Big Hand', 'Ignore tackle zones when picking up the ball.', 'normal', 'MUT'),
(29, 'Very Long Legs', '+2 to Intercept rolls and +1 to Jump over players.', 'normal', 'MUT'),

-- General / Intelligence (GEN) Skills
(30, 'Sure Hands', 'Reroll failed pickup rolls and immune to Strip Ball.', 'normal', 'GEN'),
(31, 'Kick', 'Allows placing the kick-off more precisely.', 'normal', 'GEN'),
(32, 'Leader', 'Grants an extra team reroll as long as the player is on the pitch.', 'double', 'GEN'),
(33, 'Pro', '3+ roll to reroll a single die not using team rerolls.', 'normal', 'GEN'),
(34, 'Kick-Off Return', 'Move 3 squares before the ball lands on kick-off.', 'normal', 'GEN'),
(35, 'Strip Ball', 'Takes the ball on a push result.', 'normal', 'GEN'),
(36, 'Pass Block', 'Move up to 3 squares when opponent declares a pass.', 'normal', 'GEN'),
(37, 'Safe Throw', 'Ignores interception on a 2+ roll.', 'normal', 'GEN'),
(38, 'Nerves of Steel', 'Ignore tackle zones on catch, pass, or intercept rolls.', 'normal', 'GEN'),
(39, 'Shadowing', 'Opponent must beat your MA on 2d6 to escape after dodging away.', 'normal', 'GEN'),
(40, 'Dump-Off', 'Attempt a quick pass if blocked.', 'normal', 'GEN'),

-- Traits
(41, 'Regeneration', 'On a 4+, recover instead of being removed from game.', 'trait', 'MUT'),
(42, 'Loner', 'Must roll 4+ to use a team reroll.', 'trait', 'GEN'),
(43, 'Really Stupid', 'Roll 4+ to act, 2+ if adjacent to team-mate.', 'trait', 'MUT'),
(44, 'Stunty', '+1 to dodge, but more vulnerable to injury and no tackle zone negation.', 'trait', 'MUT'),
(45, 'No Hands', 'Cannot pick up, catch, or intercept the ball.', 'trait', 'MUT'),
(46, 'Throw Team-Mate', 'Can throw players with Right Stuff.', 'trait', 'MUT'),
(47, 'Blood Lust', 'Roll 2+ or must bite a Thrall or lose turn.', 'trait', 'MUT'),
(48, 'Nurgle’s Rot', 'Permanently adds a Rotter to your roster if opponent dies.', 'trait', 'MUT');

INSERT INTO skill (id, name, description, type, category) VALUES
(49, 'Always Hungry', 'May eat the teammate being thrown if throwing a team-mate.', 'trait', 'EXT'),
(50, 'Animosity', 'May refuse to act with certain teammates.', 'trait', 'EXT'),
(51, 'Ball and Chain', 'Forced random movement; auto-pass Dodge.', 'trait', 'EXT'),
(52, 'Bombardier', 'Can perform Throw‑Bomb special action once per turn.', 'trait', 'EXT'),
(53, 'Bone‑Head', 'Roll 1 on d6 after declaring action: activation ends.', 'trait', 'EXT'),
(54, 'Breathe Fire', 'Use flame breath instead of a Block action.', 'trait', 'EXT'),
(55, 'Chainsaw', 'Chainsaw special attack instead of Block.', 'trait', 'EXT'),
(56, 'Decay', 'Roll twice on casualty table; apply both results.', 'trait', 'EXT'),
(57, 'Drunkard', '–1 penalty when rushing.', 'trait', 'EXT'),
(58, 'Fan Favourite', 'Boosts kick‑off result.', 'trait', 'EXT'),
(59, 'Hit and Run', 'May move one square after Block, ignoring Tackle Zones.', 'trait', 'EXT'),
(60, 'Hypnotic Gaze', 'Remove opponent’s tackle zones after an agility test.', 'trait', 'EXT'),
(61, 'Nurgle׳s Rot', 'Summon a Rotter when an opponent dies.', 'trait', 'EXT'),
(62, 'Pick‑Me‑Up', 'Prone teammates may stand at end of opponent turn on a 5+ roll.', 'trait', 'EXT'),
(63, 'Projectile Vomit', 'Acid spit special action instead of Block.', 'trait', 'EXT'),
(64, 'Secret Weapon', 'Sent‑off at end of drive.', 'trait', 'EXT'),
(65, 'Stab', 'Perform Stab special action instead of Block.', 'trait', 'EXT'),
(66, 'Stakes', '+1 Armour on Stab vs Khemri/Necro/Vampire/Undead teams.', 'trait', 'EXT'),
(67, 'Stunty', '+1 Dodge, fragile, ignore tackle zones.', 'trait', 'EXT'),
(68, 'Timmm‑ber!', '+1 to stand‑up roll if MA≤2.', 'trait', 'EXT'),
(69, 'Unchanneled Fury', 'May lose activation on Block if roll low.', 'trait', 'EXT'),
(70, 'Wild Animal', 'May roar and lose activation if roll low.', 'trait', 'EXT'),
(71, 'Defensive', 'Cancels Guard skill on opponents during your turn.', 'normal', 'GEN'),
(72, 'On The Ball', 'May move up to 3 squares when a pass or kick is declared by the opponent.', 'normal', 'GEN');
