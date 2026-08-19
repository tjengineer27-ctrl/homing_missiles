# ============================================================
# HOMING MISSILE - PROCESS ONE CONTROLLER
# ============================================================

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id


# ============================================================
# INITIALIZE PN MOVEMENT STATE — ONCE
# ============================================================

execute unless entity @s[tag=pn_initialized] run function missile:pn_initialize


# ============================================================
# LOAD THIS CONTROLLER'S IMPACT TARGET ID
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #impact_target_id impact_target_id = @s tracker_target

scoreboard players operation @s impact_target_id = #impact_target_id impact_target_id


# ============================================================
# CLEAR PREVIOUS TEMPORARY MOVEMENT TARGET
# ============================================================

tag @e[type=#missile:valid_targets,tag=guidance_move_target] remove guidance_move_target


# ============================================================
# CLEAR PREVIOUS GUIDANCE TARGET
# ============================================================

tag @e[type=#missile:valid_targets,tag=guidance_target] remove guidance_target


# ============================================================
# CLEAR PREVIOUS DISTANCE STATE
# ============================================================

tag @s remove guidance_at_target


# ============================================================
# COPY TRACKER TARGET ID
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #guidance_target target_id = @s tracker_target


# ============================================================
# RESOLVE CURRENT TARGET
# ============================================================

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run tag @s add guidance_target


# ============================================================
# RETARGET IF CURRENT TARGET IS LOST
# ============================================================

execute unless entity @e[type=#missile:valid_targets,tag=guidance_target] if score #guidance_target target_id matches 1.. if entity @s[tag=!missile_impact] run function missile:retarget


# ============================================================
# RELOAD TARGET ID AFTER RETARGET
# ============================================================

execute unless entity @e[type=#missile:valid_targets,tag=guidance_target] run scoreboard players set #guidance_target target_id 0

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #guidance_target target_id = @s tracker_target


# ============================================================
# RESOLVE NEW TARGET
# ============================================================

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run tag @s add guidance_target


# ============================================================
# ASSIGN TEMPORARY MOVEMENT TARGET
# ============================================================

execute as @e[type=#missile:valid_targets,tag=guidance_target] run tag @s add guidance_move_target


# ============================================================
# PROCESS GUIDANCE VECTOR
# ============================================================

function missile:guidance_vector


# ============================================================
# PROCESS PROPORTIONAL NAVIGATION
# ============================================================

function missile:proportional_navigation


# ============================================================
# UPDATE MISSILE VISUAL
# ============================================================

execute unless entity @s[tag=missile_impact] run function missile:visual_guidance


# ============================================================
# DISTANCE STATE
# ============================================================
#
# guidance_distance:
#
#     distance² × 10,000
#
# Therefore:
#
#     1 block  = 10,000
#     2 blocks = 40,000
#
# ============================================================

scoreboard players set @s guidance_in_range 0

execute if score #guidance_distance guidance_distance matches ..40000 run scoreboard players set @s guidance_in_range 1

execute if score @s guidance_in_range matches 1 run tag @s add guidance_at_target


# ============================================================
# ARRIVAL TRANSITION TEST
# ============================================================

execute if entity @s[tag=guidance_at_target,tag=!guidance_arrival_reported] run tag @s add guidance_arrival_reported


# ============================================================
# IMPACT TRANSITION TEST
# ============================================================

execute if entity @s[tag=guidance_at_target,tag=!missile_impact] run tag @s add missile_impact


# ============================================================
# AOE TARGET DETECTION
# ============================================================

execute if entity @s[tag=missile_impact,tag=!aoe_detection_complete] run function missile:aoe_detection


# ============================================================
# MARK AOE DETECTION COMPLETE
# ============================================================

execute if entity @s[tag=missile_impact,tag=!aoe_detection_complete] run tag @s add aoe_detection_complete


# ============================================================
# WARHEAD PROCESSING
# ============================================================

execute if entity @s[tag=missile_impact] run function missile:warhead


# ============================================================
# CLEANUP DETONATED MISSILE
# ============================================================

execute if entity @s[tag=missile_impact] run function missile:missile_cleanup


# ============================================================
# PROCESS THIS CONTROLLER'S MOVEMENT
# ============================================================
#
# The controller is the missile.
#
# The movement function is responsible for:
#
#     PN direction
#         ↓
#     velocity
#         ↓
#     controller teleport
#
# ============================================================

execute unless entity @s[tag=missile_impact] run function missile:movement_guidance