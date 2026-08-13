# ============================================================
# HOMING MISSILE - GUIDANCE VECTOR
# ============================================================

# ------------------------------------------------------------
# CONTROLLER POSITION
# ------------------------------------------------------------

execute store result score #controller_x guidance_cx run data get entity @s Pos[0] 1000
execute store result score #controller_y guidance_cy run data get entity @s Pos[1] 1000
execute store result score #controller_z guidance_cz run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# TARGET POSITION
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run execute store result score #target_x guidance_tx run data get entity @s Pos[0] 1000

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run execute store result score #target_y guidance_ty run data get entity @s Pos[1] 1000

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run execute store result score #target_z guidance_tz run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# CALCULATE GUIDANCE VECTOR
# ------------------------------------------------------------

scoreboard players operation @s guidance_dx = #target_x guidance_tx
scoreboard players operation @s guidance_dx -= #controller_x guidance_cx

scoreboard players operation @s guidance_dy = #target_y guidance_ty
scoreboard players operation @s guidance_dy -= #controller_y guidance_cy

scoreboard players operation @s guidance_dz = #target_z guidance_tz
scoreboard players operation @s guidance_dz -= #controller_z guidance_cz

# ------------------------------------------------------------
# REDUCE GUIDANCE VECTOR SCALE
# ------------------------------------------------------------

scoreboard players operation #distance_x guidance_dist_x = @s guidance_dx
scoreboard players operation #distance_x guidance_dist_x /= #scale_10 guidance_scale

scoreboard players operation #distance_y guidance_dist_y = @s guidance_dy
scoreboard players operation #distance_y guidance_dist_y /= #scale_10 guidance_scale

scoreboard players operation #distance_z guidance_dist_z = @s guidance_dz
scoreboard players operation #distance_z guidance_dist_z /= #scale_10 guidance_scale

# ------------------------------------------------------------
# SQUARE EACH COMPONENT
# ------------------------------------------------------------

scoreboard players operation #distance_x guidance_dist_x *= #distance_x guidance_dist_x
scoreboard players operation #distance_y guidance_dist_y *= #distance_y guidance_dist_y
scoreboard players operation #distance_z guidance_dist_z *= #distance_z guidance_dist_z

# ------------------------------------------------------------
# SUM SQUARED COMPONENTS
# ------------------------------------------------------------

scoreboard players operation #guidance_distance guidance_distance = #distance_x guidance_dist_x

scoreboard players operation #guidance_distance guidance_distance += #distance_y guidance_dist_y

scoreboard players operation #guidance_distance guidance_distance += #distance_z guidance_dist_z