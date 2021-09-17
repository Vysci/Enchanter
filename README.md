# Enchanter
WoW Addon that helps enchanters get connected with those looking for enchants. This add-on will not blindly invite anyone who is looking for an enchant, it will only invite those who are looking for enchant that the enchanter has. 

Enchanter scans and saves your characters known enchanting recipes, it will then be parsing chat for any requests that match the known recipes. Once there is a match it will auto invite the person and whisper them a link to all of the requested enchant recipes that the enchanter is capable of doing. 

If you discover that a request was either wrongfully matched or not matched please provide the full request message

## Usage VERY IMPORTANT

You need to first run /ec scan this will store your known recipes and will be parsing chat for them (only need to do it 1 time or if you learned new recipes) after run /ec start to start looking for requests

/ec scan MUST BE RAN PRIOR TO /ec start   Scans and stores your enchanting recipes to be used when filtering for requests. NOTE: You need to rerun this when you learn new recipes
/ec start Starts scanning chat (/ec scan must have been at some point)
/ec stop/pause pauses scanning
/ec debug displays debug messages
/ec about displays usage

## THIS ADDON IS CURRENTLY IN VERY EARLY STAGES
What this means is:
  - Bugs are going to happen ie not inviting someone who should be invited or inviting the wrong person
  - It doesn't have every single possible recipe, only the most popular once
  - Lots of missing features

## Known Issues:
- A person will only ever be invited to the group once (THIS IS INTENDED BEHAVIOR) regardless of how many times they post or what they post. This is in case there is a bug with the addon and it wrongfully matches a request, we don't want to keep spamming invite to the person every time they repost the message. Doing a /reload will clear the counter
- Messages that are just "LF Enchanter" will be ignored (THIS IS INTENDED BEHAVIOR)
- On occasion a whisper don't be send

## Future Features
- Having settings 
- Ability to modify tags
- Maybe more professions (prob not)
