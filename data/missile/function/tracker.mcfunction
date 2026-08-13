# ============================================================
# HOMING MISSILE - TRACKER SETUP
# ============================================================

# ------------------------------------------------------------
# CREATE TRACKER FOR EACH CONTROLLER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s run summon minecraft:marker ~ ~ ~ {Tags:["missile_tracker"]}

# ------------------------------------------------------------
# ASSIGN TRACKER'S CONTROLLER ID
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s run scoreboard players operation @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] tracker_controller_id = @s controller_id

# ------------------------------------------------------------
# ATTACH TRACKER TO CONTROLLER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s run ride @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] mount @s

# ------------------------------------------------------------
# COPY SELECTED TARGET ID TO TRACKER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s run scoreboard players operation @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] tracker_target = @e[type=#missile:valid_targets,distance=..64,sort=nearest,limit=1] target_id

# ------------------------------------------------------------
# MARK TRACKER AS HAVING A TARGET
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s run tag @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] add tracker_has_target

# ------------------------------------------------------------
# MARK TRACKER CREATED
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!tracker_created] at @s if entity @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] run tag @s add tracker_created