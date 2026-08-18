# ============================================================
# HOMING MISSILE - PROCESS ONE CONTROLLER
# ============================================================

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# scoreboard players set @s pn_speed_scale 1

# ============================================================
# INITIAL PN MOVEMENT STATE
# ============================================================

scoreboard players set @s missile_vx 250
scoreboard players set @s missile_vy 0
scoreboard players set @s missile_vz 0

scoreboard players set @s pn_speed_scale 250

scoreboard players set @s pn_dir_x 1000
scoreboard players set @s pn_dir_y 0
scoreboard players set @s pn_dir_z 0

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
# RETARGET IF CURRENT TARGET IS LOST
# ------------------------------------------------------------

execute unless entity @e[type=#missile:valid_targets,tag=guidance_target] if score #guidance_target target_id matches 1.. if entity @s[tag=!missile_impact] run function missile:retarget

# ------------------------------------------------------------
# RELOAD TARGET ID AFTER RETARGETING
# ------------------------------------------------------------

execute unless entity @e[type=#missile:valid_targets,tag=guidance_target] run scoreboard players set #guidance_target target_id 0

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run scoreboard players operation #guidance_target target_id = @s tracker_target

# ------------------------------------------------------------
# RESOLVE NEW TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run tag @s add guidance_target

# ------------------------------------------------------------
# ASSIGN TEMPORARY MOVEMENT TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=guidance_target] run tag @s add guidance_move_target

# ------------------------------------------------------------
# SAVE PREVIOUS VISIBLE MISSILE POSITION
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_prev_x = @s missile_x

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_prev_y = @s missile_y

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_prev_z = @s missile_z

# ------------------------------------------------------------
# LOAD CURRENT VISIBLE MISSILE POSITION
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id store result score @s missile_x run data get entity @s Pos[0] 1000

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id store result score @s missile_y run data get entity @s Pos[1] 1000

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id store result score @s missile_z run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# CALCULATE VISIBLE MISSILE VELOCITY
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vx = @s missile_x

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vx -= @s missile_prev_x

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vy = @s missile_y

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vy -= @s missile_prev_y

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vz = @s missile_z

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation @s missile_vz -= @s missile_prev_z

# ------------------------------------------------------------
# COPY VISIBLE MISSILE VELOCITY TO CONTROLLER
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation #active_missile_vx missile_vx = @s missile_vx

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation #active_missile_vy missile_vy = @s missile_vy

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run scoreboard players operation #active_missile_vz missile_vz = @s missile_vz

scoreboard players operation @s missile_vx = #active_missile_vx missile_vx
scoreboard players operation @s missile_vy = #active_missile_vy missile_vy
scoreboard players operation @s missile_vz = #active_missile_vz missile_vz

# ------------------------------------------------------------
# PROCESS THIS CONTROLLER'S VECTOR
# ------------------------------------------------------------

function missile:guidance_vector

# ------------------------------------------------------------
# PROCESS PROPORTIONAL NAVIGATION
# ------------------------------------------------------------

function missile:proportional_navigation

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