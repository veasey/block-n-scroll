# BLOCK N SCROLL 🏉🐦
A free alternative to the other bloodbowl tracker. 

Things this will do that others do not:
- allow a single league to have "seasons" baked in, without having to create a new league each time.
- allow overwrites of any stats and rules (to correct fat finger moments, or create custom chaos in custom leagues)
- a dice roller, in case you lose a dice (or one gets flung in frustration and can't be retrieved)
- when creating a match, it will autofill the box to select the current time and not make YOU SCROLL DOWN FROM MIDNIGHT TO THE CURRENT TIME!!!! ARGHHHHH!!!!
- All league admins / moderators to share news and photos of events.
- Allow notes to be added (and pictures) of special, interesting or funny things that happen in matches.
- Detailed history and stats of leagues across seasons, building up a history and archive.

### Run Up (Locally)

Bring Up: `docker-compose -f docker-compose.yml up --build -d`
Bring Down / Restart: `docker compose down -v` (as schema only builds on initial build of container)
Make appear online (temp measure): `cloudflared tunnel --url http://localhost:8000`