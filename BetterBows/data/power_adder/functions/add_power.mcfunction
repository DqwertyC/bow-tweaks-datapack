# Get a power score based on the enchantment level of the bow that shot this arrow
execute store result score @s[tag=mainhand] power run data get entity @e[tag=current_owner,limit=1] SelectedItem.tag.Enchantments[{id:"minecraft:power"}].lvl
execute store result score @s[tag=offhand] power run data get entity @e[tag=current_owner,limit=1] Inventory[{Slot:-106b}].tag.Enchantments[{id:"minecraft:power"}].lvl

# Read in the starting velocity of this arrow
execute store result score @s init_vel_x run data get entity @s Motion[0] 10000
execute store result score @s init_vel_y run data get entity @s Motion[1] 10000
execute store result score @s init_vel_z run data get entity @s Motion[2] 10000

# Get the total power multiplier
scoreboard players operation @s power *= PowerPerLevel val
scoreboard players operation @s power += PowerDivisor val

# Scale the velocity
scoreboard players operation @s init_vel_x *= @s power
scoreboard players operation @s init_vel_y *= @s power
scoreboard players operation @s init_vel_z *= @s power

scoreboard players operation @s init_vel_x /= PowerDivisor val
scoreboard players operation @s init_vel_y /= PowerDivisor val
scoreboard players operation @s init_vel_z /= PowerDivisor val

# Apply the velocity to the arrow
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get @s init_vel_x
execute store result entity @s Motion[1] double 0.0001 run scoreboard players get @s init_vel_y
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get @s init_vel_z