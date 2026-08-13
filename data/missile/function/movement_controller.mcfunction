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
# FIND THIS CONTROLLER'S VISUAL
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run tag @s add follow_controller

# ------------------------------------------------------------
# MOVE TRACKER TO CONTROLLER
# ------------------------------------------------------------

tp @e[type=minecraft:marker,tag=missile_tracker,tag=follow_controller,limit=1] ~ ~ ~

# ------------------------------------------------------------
# MOVE VISUAL TO CONTROLLER
# ------------------------------------------------------------

tp @e[type=minecraft:item_display,tag=missile_visual,tag=follow_controller,limit=1] ~ ~ ~

# ------------------------------------------------------------
# CLEAR TEMPORARY FOLLOW TAGS
# ------------------------------------------------------------

tag @e[type=minecraft:marker,tag=missile_tracker,tag=follow_controller] remove follow_controller

tag @e[type=minecraft:item_display,tag=missile_visual,tag=follow_controller] remove follow_controller
