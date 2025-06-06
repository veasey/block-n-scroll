/* Core schema */
SOURCE schema/01_core.sql;
SOURCE schema/02_races.sql;
SOURCE schema/03_players.sql;
SOURCE schema/04_matches.sql;
SOURCE schema/05_rules.sql;
SOURCE schema/99_constraints.sql;

/* SEED DATA */
SOURCE seed/injuries.sql;
SOURCE seed/positions.sql;
SOURCE seed/races.sql;
SOURCE seed/skills.sql;

/* DEFAULT NAMES */
SOURCE seed/default_names/default_names_amazons.sql;
SOURCE seed/default_names/default_names_black_orcs.sql;
SOURCE seed/default_names/default_names_bretonnia.sql;
SOURCE seed/default_names/default_names_chaos_chosen.sql;
SOURCE seed/default_names/default_names_chaos_dwarves.sql;
SOURCE seed/default_names/default_names_chaos_renegades.sql;
SOURCE seed/default_names/default_names_daemons_of_khorne.sql;
SOURCE seed/default_names/default_names_dark_elves.sql;
SOURCE seed/default_names/default_names_dwarfs.sql;
SOURCE seed/default_names/default_names_goblins.sql;
SOURCE seed/default_names/default_names_humans.sql;
SOURCE seed/default_names/default_names_lizardmen.sql;
SOURCE seed/default_names/default_names_orgres.sql;
SOURCE seed/default_names/default_names_orcs.sql;
SOURCE seed/default_names/default_names_skaven.sql;