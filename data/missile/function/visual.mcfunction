# ============================================================ 
# HOMING MISSILE - CREATE VISUAL 
# ============================================================ 

# ------------------------------------------------------------ 
# CREATE FIREWORK ROCKET VISUAL 
# ------------------------------------------------------------ 
execute as @e[type=minecraft:marker,tag=missile_controller,tag=!visual_created] at @s run summon minecraft:item_display ~ ~ ~ {item:{id:"minecraft:firework_rocket",count:1},Tags:["missile_visual"]} 

# ------------------------------------------------------------ 
# COPY CONTROLLER ID TO VISUAL 
# ------------------------------------------------------------ 
execute as @e[type=minecraft:marker,tag=missile_controller,tag=!visual_created] at @s run scoreboard players operation @e[type=minecraft:item_display,tag=missile_visual,distance=..1,limit=1,sort=nearest] visual_controller_id = @s controller_id 

# ------------------------------------------------------------ 
# MARK VISUAL CREATED 
# ------------------------------------------------------------ 
execute as @e[type=minecraft:marker,tag=missile_controller,tag=!visual_created] at @s if entity @e[type=minecraft:item_display,tag=missile_visual,distance=..1,limit=1,sort=nearest] run tag @s add visual_created