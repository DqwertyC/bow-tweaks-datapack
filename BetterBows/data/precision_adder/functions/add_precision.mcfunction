# Get precision data from the owner
scoreboard players operation @s precision = @e[tag=current_owner,limit=1] precision

# Get actual starting velocity
execute store result score @s init_vel_x run data get entity @s Motion[0] 10000
execute store result score @s init_vel_y run data get entity @s Motion[1] 10000
execute store result score @s init_vel_z run data get entity @s Motion[2] 10000

# Get orientation data from the owner
execute positioned 0.0 0.0 0.0 rotated as @e[tag=current_owner,limit=1] run summon minecraft:marker ^ ^ ^1 {Tags:["current_marker"]}

execute store result score @s ideal_vel_x run data get entity @e[tag=current_marker,limit=1] Pos[0] 10000
execute store result score @s ideal_vel_y run data get entity @e[tag=current_marker,limit=1] Pos[1] 10000
execute store result score @s ideal_vel_z run data get entity @e[tag=current_marker,limit=1] Pos[2] 10000

kill @e[tag=current_marker]

# Determine the ideal starting velocity
scoreboard players set @s val 3

scoreboard players operation @s ideal_vel_x *= @s val
scoreboard players operation @s ideal_vel_y *= @s val
scoreboard players operation @s ideal_vel_z *= @s val

# Determine the amount of jitter present
scoreboard players operation @s jitter_vel_x = @s init_vel_x
scoreboard players operation @s jitter_vel_y = @s init_vel_y
scoreboard players operation @s jitter_vel_z = @s init_vel_z

scoreboard players operation @s jitter_vel_x -= @s ideal_vel_x
scoreboard players operation @s jitter_vel_y -= @s ideal_vel_y
scoreboard players operation @s jitter_vel_z -= @s ideal_vel_z

# Scale the amount of jitter based on precision
scoreboard players operation @s val = MaxPrecision val
scoreboard players operation @s val -= @s precision

scoreboard players operation @s jitter_x = @s jitter_vel_x
scoreboard players operation @s jitter_y = @s jitter_vel_y
scoreboard players operation @s jitter_z = @s jitter_vel_z

scoreboard players operation @s jitter_x *= @s val
scoreboard players operation @s jitter_y *= @s val
scoreboard players operation @s jitter_z *= @s val

scoreboard players operation @s jitter_x /= MaxPrecision val
scoreboard players operation @s jitter_y /= MaxPrecision val
scoreboard players operation @s jitter_z /= MaxPrecision val

# Add scaled jitter to the ideal velocity
scoreboard players operation @s init_vel_x = @s ideal_vel_x
scoreboard players operation @s init_vel_y = @s ideal_vel_y
scoreboard players operation @s init_vel_z = @s ideal_vel_z

scoreboard players operation @s init_vel_x += @s jitter_x
scoreboard players operation @s init_vel_y += @s jitter_y
scoreboard players operation @s init_vel_z += @s jitter_z

# Set arrow motion data
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get @s init_vel_x
execute store result entity @s Motion[1] double 0.0001 run scoreboard players get @s init_vel_y
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get @s init_vel_z