# Store entity's id in a scoreboard
execute as @e[tag=!uuid_stored] run function owner_finder:store_uuid

# Get info from an arrow's owner if it hasn't been tagged yet
execute as @e[type=#minecraft:arrows,tag=!initialized] run function owner_finder:init_arrow