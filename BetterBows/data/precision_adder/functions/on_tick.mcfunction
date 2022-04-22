# Update the player's draw_time score
execute as @a[advancements={precision_adder:drawing_bow=true},scores={sneaking=1..}] run scoreboard players add @s draw_time 1
execute as @a[advancements={precision_adder:drawing_bow=false}] run scoreboard players set @s draw_time 0
advancement revoke @a only precision_adder:drawing_bow

# Set the player's precision based on draw_time
execute as @e[scores={draw_time=0}] run scoreboard players set @s precision 0

# Play tones to let the player know how precise they are
execute as @a[scores={draw_time=30}] run playsound minecraft:block.note_block.guitar player @s ~ ~ ~ 1.5 0.8 1
execute as @a[scores={draw_time=30}] run scoreboard players set @s precision 2

execute as @a[scores={draw_time=40}] run playsound minecraft:block.note_block.guitar player @s ~ ~ ~ 1.5 1.0 1
execute as @a[scores={draw_time=40}] run scoreboard players set @s precision 4

execute as @a[scores={draw_time=55}] run playsound minecraft:block.note_block.guitar player @s ~ ~ ~ 1.5 1.2 1
execute as @a[scores={draw_time=55}] run scoreboard players set @s precision 6

execute as @a[scores={draw_time=75}] run playsound minecraft:block.note_block.guitar player @s ~ ~ ~ 1.5 1.4 1
execute as @a[scores={draw_time=75}] run scoreboard players set @s precision 8

execute as @a[scores={draw_time=100}] run playsound minecraft:block.note_block.guitar player @s ~ ~ ~ 1.5 1.6 1
execute as @a[scores={draw_time=100}] run scoreboard players set @s precision 10

# Reset the sneaking score for all players
scoreboard players reset @a sneaking