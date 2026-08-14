# ============================================================
# HOMING MISSILE - PROCESS ONE CONTROLLER
# ============================================================

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# ------------------------------------------------------------
# INITIALIZE CONTROLLER CONFIGURATION
# ------------------------------------------------------------

scoreboard players operation @s warhead_type = #config_warhead missile_config
scoreboard players operation @s warhead_yield = #config_yield missile_config
scoreboard players operation @s potion_type = #config_potion missile_config

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S IMPACT TARGET ID
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #impact_target_id impact_target_id = @s tracker_target

scoreboard players operation @s impact_target_id = #impact_target_id impact_target_id

# ------------------------------------------------------------
# CLEAR PREVIOUS TEMPORARY MOVEMENT TARGET
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=guidance_move_target] remove guidance_move_target

# ------------------------------------------------------------
# CLEAR PREVIOUS GUIDANCE TARGET
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=guidance_target] remove guidance_target

# ------------------------------------------------------------
# CLEAR PREVIOUS DISTANCE STATE
# ------------------------------------------------------------

tag @s remove guidance_at_target

# ------------------------------------------------------------
# COPY THIS CONTROLLER'S TRACKER TARGET ID
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #guidance_target target_id = @s tracker_target

# ------------------------------------------------------------
# RESOLVE THIS CONTROLLER'S TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run tag @s add guidance_target

# ------------------------------------------------------------
# ASSIGN TEMPORARY MOVEMENT TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=guidance_target] run tag @s add guidance_move_target

# ------------------------------------------------------------
# PROCESS THIS CONTROLLER'S VECTOR
# ------------------------------------------------------------

function missile:guidance_vector

# ------------------------------------------------------------
# CALCULATE THIS MISSILE'S YIELD VALUES
# ------------------------------------------------------------

# function missile:calculate_yield

# ------------------------------------------------------------
# UPDATE MISSILE VISUAL
# ------------------------------------------------------------

execute unless entity @s[tag=missile_impact] run function missile:visual_guidance

# ------------------------------------------------------------
# DISTANCE STATE
# ------------------------------------------------------------

scoreboard players set @s guidance_in_range 0

execute if score #guidance_distance guidance_distance matches ..40000 run scoreboard players set @s guidance_in_range 1

execute if score @s guidance_in_range matches 1 run tag @s add guidance_at_target

# ------------------------------------------------------------
# ARRIVAL TRANSITION TEST
# ------------------------------------------------------------

execute if entity @s[tag=guidance_at_target,tag=!guidance_arrival_reported] run tag @s add guidance_arrival_reported

# ------------------------------------------------------------
# IMPACT TRANSITION TEST
# ------------------------------------------------------------

execute if entity @s[tag=guidance_at_target,tag=!missile_impact] run tag @s add missile_impact

# ------------------------------------------------------------
# AOE TARGET DETECTION
# ------------------------------------------------------------

# Only perform the AoE scan once per missile

execute if entity @s[tag=missile_impact,tag=!aoe_detection_complete] run function missile:aoe_detection

# ------------------------------------------------------------
# MARK AOE DETECTION COMPLETE
# ------------------------------------------------------------

execute if entity @s[tag=missile_impact,tag=!aoe_detection_complete] run tag @s add aoe_detection_complete

# ------------------------------------------------------------
# SHARED PRIMARY TARGET DAMAGE
# ------------------------------------------------------------

scoreboard players get #active_controller controller_id

# ------------------------------------------------------------
# WARHEAD PROCESSING DEBUG
# ------------------------------------------------------------

execute if entity @s[tag=missile_impact] run function missile:warhead

# ------------------------------------------------------------
# CLEANUP DETONATED MISSILE
# ------------------------------------------------------------

execute if entity @s[tag=missile_impact] run function missile:missile_cleanup

# ------------------------------------------------------------
# PROCESS THIS CONTROLLER'S MOVEMENT
# ------------------------------------------------------------

execute unless entity @s[tag=missile_impact] run function missile:movement_guidance