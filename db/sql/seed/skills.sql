DELETE FROM skill;
DELETE FROM skill_category;

INSERT INTO skill_category (id, name, description) VALUES
(1, 'General', 'General skills and intelligence-based actions.'),
(2, 'Agility', 'Skills that improve dodging, catching, and movement agility.'),
(3, 'Strength', 'Skills that enhance physical strength and blocking capabilities.'),
(4, 'Passing', 'Skills that improve passing and ball handling.'),
(5, 'Mutations', 'Special skills related to mutations and unique traits.'),
(6, 'Traits', 'Traits that provide unique player characteristics.'),
(7, 'Extraordinary', 'Extraordinary traits and skills.');

-- Strength (STR) Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(1, 'Block', 'The player is not knocked down on a Both Down result.', 'normal', 'Strength'),
(2, 'Mighty Blow', 'Adds +1 to either the Armour or Injury roll when the player knocks down an opponent.', 'normal', 'Strength'),
(3, 'Grab', 'Cancels Side Step and allows placing the opponent in any adjacent square on a push.', 'normal', 'Strength'),
(4, 'Tackle', 'Cancels Dodge on Block and prevents Dodge rerolls.', 'normal', 'Strength'),
(5, 'Claw', 'Opponent’s Armour value is considered as 8+ for Injury rolls.', 'normal', 'Strength'),
(6, 'Horns', 'Adds +1 Strength when making a Blitz action.', 'normal', 'Strength'),
(7, 'Stand Firm', 'Player is not pushed back on a Block unless knocked down.', 'normal', 'Strength'),
(8, 'Juggernaut', 'On a Blitz, treats Both Down and Push as Push and negates Stand Firm and Wrestle.', 'normal', 'Strength'),
(9, 'Thick Skull', 'Injury rolls of 9 become a Stunned result instead of KO.', 'normal', 'Strength'),
(10, 'Wrestle', 'Both players go prone on a Both Down, but neither is considered knocked down.', 'normal', 'Strength'),
(11, 'Guard', 'Allowing a player to assist blocks made by adjacent teammates.', 'normal', 'Strength'),
(12, 'Brawler', 'If this player is knocked down on a Block result, the opponent’s armour roll suffers -1.', 'normal', 'Strength'),
(13, 'Dauntless', 'Ignores the effects of the Frenzy skill on opponents.', 'normal', 'Strength'),
(14, 'Piledriver', 'Can push an opponent and knock them down on a Push result.', 'normal', 'Strength');

-- Agility (AG) Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(20, 'Dodge', 'Allows rerolling failed Dodge rolls and cancels Tackle’s effects unless negated.', 'normal', 'Agility'),
(21, 'Catch', 'Reroll failed catch, interception, or bouncing ball attempts.', 'normal', 'Agility'),
(22, 'Leap', 'Allows jumping into any adjacent square; uses Agility roll.', 'normal', 'Agility'),
(23, 'Sprint', 'Allows attempting up to 3 GFI rolls instead of 2.', 'normal', 'Agility'),
(24, 'Diving Catch', 'Adds +1 to catch rolls for accurate passes and allows catching in adjacent squares.', 'normal', 'Agility'),
(25, 'Fend', 'Prevents opponent from following up when they block you.', 'normal', 'General'), -- Fend is a General skill
(26, 'Jump Up', 'Stand up without spending Movement and can Block from prone with AG roll.', 'normal', 'Agility'),
(27, 'Side Step', 'Choose any adjacent square on push instead of being pushed back.', 'normal', 'Agility'),
(28, 'Sure Feet', 'Reroll one failed GFI per turn.', 'normal', 'Agility'),
(29, 'Break Tackle', 'Allows the player to make an extra dodge after successfully dodging.', 'normal', 'Agility'),
(30, 'Sneaky Git', 'The player may move through tackle zones without being tackled.', 'normal', 'Agility'),
(31, 'Diving Tackle', 'The player can tackle after dodging away.', 'normal', 'Agility'),
(32, 'Safe Pair of Hands', 'The player can reroll failed pickup rolls.', 'normal', 'Agility');

-- Passing (PAS) Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(40, 'Safe Pass', 'If a Pass Action fumbles, the ball is not dropped and remains in the thrower’s possession.', 'normal', 'Passing'),
(41, 'Cloud Burster', 'Adds -1 modifier to the opposing player’s Interception roll for this player’s Pass Action.', 'normal', 'Passing'),
(42, 'Pass', 'Allows the player to reroll failed Pass actions.', 'normal', 'Passing'),
(43, 'Accurate', '+1 modifier to passing rolls.', 'normal', 'Passing'),
(44, 'Running Pass', 'Allows the player to move after a Quick Pass action if they have Movement left.', 'normal', 'Passing'),
(45, 'Cannoneer', 'When throwing a Bombardier special action, can throw further.', 'normal', 'Passing'),
(46, 'Fumblerooskie', 'Allows an unusual backward pass that fools the opponent.', 'normal', 'Passing');

-- Mutation (MUT) Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(50, 'Tentacles', 'Opponent must make a Strength test to dodge away from the player.', 'normal', 'Mutations'),
(51, 'Extra Arms', '+1 to pick up, catch, or intercept the ball.', 'normal', 'Mutations'),
(52, 'Prehensile Tail', '-1 to opponents’ dodge rolls when moving away.', 'normal', 'Mutations'),
(53, 'Two Heads', '+1 to Dodge rolls.', 'normal', 'Mutations'),
(54, 'Disturbing Presence', '-1 to pass, catch, or intercept rolls within 3 squares.', 'normal', 'Mutations'),
(55, 'Hypnotic Gaze', 'Agility test to remove opponent’s tackle zones for a turn.', 'normal', 'Mutations'),
(56, 'Foul Appearance', 'Opponent must roll 2+ to block this player.', 'normal', 'Mutations'),
(57, 'Big Hand', 'Ignore tackle zones when picking up the ball.', 'normal', 'Mutations'),
(58, 'Very Long Legs', '+2 to Intercept rolls and +1 to Jump over players.', 'normal', 'Mutations');

-- General (GEN) Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(60, 'Sure Hands', 'Reroll failed pickup rolls and immune to Strip Ball.', 'normal', 'General'),
(61, 'Kick', 'Allows placing the kick-off more precisely.', 'normal', 'General'),
(62, 'Leader', 'Grants an extra team reroll as long as the player is on the pitch.', 'double', 'General'),
(63, 'Pro', '3+ roll to reroll a single die not using team rerolls.', 'normal', 'General'),
(64, 'Kick-Off Return', 'Move 3 squares before the ball lands on kick-off.', 'normal', 'General'),
(65, 'Strip Ball', 'Takes the ball on a push result.', 'normal', 'General'),
(66, 'Pass Block', 'Move up to 3 squares when opponent declares a pass.', 'normal', 'General'),
(67, 'Safe Throw', 'Ignores interception on a 2+ roll.', 'normal', 'General'),
(68, 'Nerves of Steel', 'Ignore tackle zones on catch, pass, or intercept rolls.', 'normal', 'General'),
(69, 'Shadowing', 'Opponent must beat your MA on 2d6 to escape after dodging away.', 'normal', 'General'),
(70, 'Dump-Off', 'Attempt a quick pass if blocked.', 'normal', 'General'),
(71, 'Defensive', 'Cancels Guard skill on opponents during your turn.', 'normal', 'General'),
(72, 'On The Ball', 'May move up to 3 squares when a pass or kick is declared by the opponent.', 'normal', 'General');

-- Traits (TRAIT)
INSERT INTO skill (id, name, description, type, category) VALUES
(80, 'Regeneration', 'On a 4+, recover instead of being removed from game.', 'trait', 'Traits'),
(81, 'Loner', 'Must roll 4+ to use a team reroll.', 'trait', 'Traits'),
(82, 'Really Stupid', 'Roll 4+ to act, 2+ if adjacent to team-mate.', 'trait', 'Traits'),
(83, 'Stunty', '+1 to dodge, but more vulnerable to injury and no tackle zone negation.', 'trait', 'Traits'),
(84, 'No Hands', 'Cannot pick up, catch, or intercept the ball.', 'trait', 'Traits'),
(85, 'Throw Team-Mate', 'Can throw players with Right Stuff.', 'trait', 'Traits'),
(86, 'Blood Lust', 'Roll 2+ or must bite a Thrall or lose turn.', 'trait', 'Traits'),
(87, 'Right Stuff', 'If this player also has a Strength characteristic of 3 or less, they can be thrown by a Team-mate with the Throw Team-mate skill, as described on page 52.', 'trait', 'TRAIT');

-- Extraordinary (EXT) Traits/Skills
INSERT INTO skill (id, name, description, type, category) VALUES
(90, 'Always Hungry', 'May eat the teammate being thrown if throwing a team-mate.', 'trait', 'Extraordinary'),
(91, 'Animosity', 'May refuse to act with certain teammates.', 'trait', 'Extraordinary'),
(92, 'Ball and Chain', 'Forced random movement; auto-pass Dodge.', 'trait', 'Extraordinary'),
(93, 'Bombardier', 'Can perform Throw‑Bomb special action once per turn.', 'trait', 'Extraordinary'),
(94, 'Bone‑Head', 'Roll 1 on d6 after declaring action: activation ends.', 'trait', 'Extraordinary'),
(95, 'Breathe Fire', 'Use flame breath instead of a Block action.', 'trait', 'Extraordinary'),
(96, 'Chainsaw', 'Chainsaw special attack instead of Block.', 'trait', 'Extraordinary'),
(97, 'Decay', 'Roll twice on casualty table; apply both results.', 'trait', 'Extraordinary'),
(98, 'Drunkard', '–1 penalty when rushing.', 'trait', 'Extraordinary'),
