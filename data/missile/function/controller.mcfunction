# ============================================================
# HOMING MISSILE - PROCESS ONE CONTROLLER
# ============================================================

# ------------------------------------------------------------
# STORE THIS CONTROLLER'S ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# ------------------------------------------------------------
# FIND THIS CONTROLLER'S TRACKER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run tag @s add follow_controller

# ------------------------------------------------------------
# FIND THIS CONTROLLER'S FIREWORK
# ------------------------------------------------------------

execute as @e[type=minecraft:firework_rocket,tag=homing_missile] if score @s missile_controller_id = #active_controller controller_id run tag @s add follow_controller

# ------------------------------------------------------------
# MOVE TRACKER TO THIS CONTROLLER
# ------------------------------------------------------------

tp @e[type=minecraft:marker,tag=missile_tracker,tag=follow_controller,limit=1] ~ ~ ~

# ------------------------------------------------------------
# MOVE FIREWORK TO THIS CONTROLLER
# ------------------------------------------------------------

tp @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller,limit=1] ~ ~ ~

# ------------------------------------------------------------
# NEUTRALIZE NATIVE FIREWORK MOVEMENT
# ------------------------------------------------------------

data modify entity @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller,limit=1] Motion set value [0.0d,0.0d,0.0d]

data modify entity @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller,limit=1] ShotAtAngle set value 1b

data modify entity @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller,limit=1] NoGravity set value 1b

# ------------------------------------------------------------
# CLEAR TEMPORARY FOLLOW TAGS
# ------------------------------------------------------------

tag @e[type=minecraft:marker,tag=missile_tracker,tag=follow_controller] remove follow_controller

tag @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller] remove follow_controller