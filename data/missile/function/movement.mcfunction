# ============================================================
# HOMING MISSILE - MOVEMENT
# ============================================================

# ------------------------------------------------------------
# CLEAR TEMPORARY FOLLOW TAGS
# ------------------------------------------------------------

tag @e[type=minecraft:marker,tag=missile_tracker,tag=follow_controller] remove follow_controller

tag @e[type=minecraft:firework_rocket,tag=homing_missile,tag=follow_controller] remove follow_controller

# ------------------------------------------------------------
# PROCESS EACH CONTROLLER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller] at @s run function missile:movement_controller