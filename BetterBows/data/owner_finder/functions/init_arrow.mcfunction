# Tag this arrow so we can always find it
tag @s add current_arrow

# Get the owner. If collisions occur, check more scores
execute as @e if score @s self_id_0 = @e[tag=current_arrow,limit=1] owner_id_0 run tag @s add current_owner

# Determine how this arrow was shot
execute if entity @e[tag=current_owner,nbt={SelectedItem:{id:"minecraft:crossbow"}}] run tag @s add mainhand
execute if entity @e[tag=current_owner,nbt={SelectedItem:{id:"minecraft:bow"}}] run tag @s add mainhand
execute unless entity @s[tag=mainhand] run tag @s add offhand

# Apply precision and power boosts from the owner
execute if entity @e[tag=current_owner,scores={precision=1..}] run function precision_adder:add_precision
function power_adder:add_power

# Reset tags
tag @s remove current_arrow
tag @e remove current_owner
tag @e remove newest_arrow
tag @s add newest_arrow
tag @s add initialized