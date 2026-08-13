# ============================================================
# HOMING MISSILE - KNOCKBACK TARGET
# ============================================================

say KNOCKBACK_TARGET FUNCTION ENTERED

# ------------------------------------------------------------
# STORE THIS TARGET'S POSITION
# ------------------------------------------------------------

execute store result score #target_x guidance_tx run data get entity @s Pos[0] 1000
execute store result score #target_y guidance_ty run data get entity @s Pos[1] 1000
execute store result score #target_z guidance_tz run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# CALCULATE OUTWARD VECTOR
# ------------------------------------------------------------

scoreboard players operation #knockback_dx knockback_dx = #target_x guidance_tx
scoreboard players operation #knockback_dx knockback_dx -= #controller_x guidance_cx

scoreboard players operation #knockback_dy knockback_dy = #target_y guidance_ty
scoreboard players operation #knockback_dy knockback_dy -= #controller_y guidance_cy

scoreboard players operation #knockback_dz knockback_dz = #target_z guidance_tz
scoreboard players operation #knockback_dz knockback_dz -= #controller_z guidance_cz

# ------------------------------------------------------------
# CALCULATE DISTANCE SQUARED
#
# Coordinates are x1000.
# Therefore distance² is x1,000,000.
# ------------------------------------------------------------

scoreboard players operation #knockback_distance knockback_distance = #knockback_dx knockback_dx
scoreboard players operation #knockback_distance knockback_distance *= #knockback_dx knockback_dx

scoreboard players operation #knockback_math knockback_math = #knockback_dy knockback_dy
scoreboard players operation #knockback_math knockback_math *= #knockback_dy knockback_dy
scoreboard players operation #knockback_distance knockback_distance += #knockback_math knockback_math

scoreboard players operation #knockback_math knockback_math = #knockback_dz knockback_dz
scoreboard players operation #knockback_math knockback_math *= #knockback_dz knockback_dz
scoreboard players operation #knockback_distance knockback_distance += #knockback_math knockback_math

# ------------------------------------------------------------
# CALCULATE ACTUAL DISTANCE
#
# Newton-Raphson integer square root.
#
# distance² is x1,000,000.
# distance root is x1000.
#
# Newton-Raphson:
#
#     root_new = (root + distance² / root) / 2
#
# Because:
#
#     distance² = x1,000,000
#     root      = x1,000
#     distance² / root = x1,000
#
# The iteration therefore stays at x1000 scale.
# ------------------------------------------------------------

# ------------------------------------------------------------
# INITIAL APPROXIMATION
# ------------------------------------------------------------

# Convert distance² from x1,000,000 to an
# initial approximation at x1000 scale.

scoreboard players operation #knockback_distance_root knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# ITERATION 1
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_distance_root knockback_scale

scoreboard players operation #knockback_distance_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 2
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_distance_root knockback_scale

scoreboard players operation #knockback_distance_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 3
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_distance_root knockback_scale

scoreboard players operation #knockback_distance_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 4
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_distance_root knockback_scale

scoreboard players operation #knockback_distance_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 5
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_distance_root knockback_scale

scoreboard players operation #knockback_distance_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_distance_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# SELECT YIELD MULTIPLIER
# ------------------------------------------------------------

# LOW    = x1.00
# MEDIUM = x1.75
# HIGH   = x2.50

scoreboard players set #knockback_multiplier knockback_scale 1000

execute if score @s warhead_yield matches 2 run scoreboard players set #knockback_multiplier knockback_scale 1750
execute if score @s warhead_yield matches 3 run scoreboard players set #knockback_multiplier knockback_scale 2500

# ------------------------------------------------------------
# LOAD BASE KNOCKBACK FROM CONTROLLER
# ------------------------------------------------------------
#
# @s is the AOE target at this point.
#
# The target stores the controller ID in aoe_controller.
# We first copy that ID into a temporary global score, then
# resolve the matching missile_controller marker and retrieve
# its yield_knockback value.
# ------------------------------------------------------------

# Copy this target's controller ID
scoreboard players operation #active_controller controller_id = @s aoe_controller

# Resolve the matching missile controller
execute as @e[type=minecraft:marker,tag=missile_controller] if score @s controller_id = #active_controller controller_id run scoreboard players operation #knockback_magnitude knockback_scale = #active_yield_knockback knockback_scale

# ------------------------------------------------------------
# DEBUG - CONTROLLER KNOCKBACK VALUE
# ------------------------------------------------------------

tellraw @a [{"text":"[Knockback Debug] Controller KB","color":"gold"},{"score":{"name":"#knockback_magnitude","objective":"knockback_scale"},"color":"aqua"}]

# ------------------------------------------------------------
# APPLY YIELD MULTIPLIER
# ------------------------------------------------------------

scoreboard players operation #knockback_magnitude knockback_scale *= #knockback_multiplier knockback_scale
scoreboard players operation #knockback_magnitude knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# CALCULATE DYNAMIC AOE RADIUS²
# ------------------------------------------------------------

scoreboard players operation #active_aoe_radius aoe_radius_squared = @s yield_radius

scoreboard players operation #active_aoe_radius aoe_radius_squared *= #aoe_scale aoe_radius_squared

scoreboard players operation #active_aoe_radius aoe_radius_squared *= #active_aoe_radius aoe_radius_squared

# ------------------------------------------------------------
# CALCULATE DISTANCE THRESHOLDS
# ------------------------------------------------------------

# 20%² = 4%
# 40%² = 16%
# 60%² = 36%
# 80%² = 64%

# ------------------------------------------------------------
# 20% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_20 knockback_scale = #active_aoe_radius aoe_radius_squared

scoreboard players set #knockback_math knockback_scale 40
scoreboard players operation #kb_20 knockback_scale *= #knockback_math knockback_scale
scoreboard players operation #kb_20 knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# 40% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_40 knockback_scale = #active_aoe_radius aoe_radius_squared

scoreboard players set #knockback_math knockback_scale 160
scoreboard players operation #kb_40 knockback_scale *= #knockback_math knockback_scale
scoreboard players operation #kb_40 knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# 60% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_60 knockback_scale = #active_aoe_radius aoe_radius_squared

scoreboard players set #knockback_math knockback_scale 360
scoreboard players operation #kb_60 knockback_scale *= #knockback_math knockback_scale
scoreboard players operation #kb_60 knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# 80% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_80 knockback_scale = #active_aoe_radius aoe_radius_squared

scoreboard players set #knockback_math knockback_scale 640
scoreboard players operation #kb_80 knockback_scale *= #knockback_math knockback_scale
scoreboard players operation #kb_80 knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# SELECT DISTANCE FALLOFF
# ------------------------------------------------------------

# 0%-20%   = 100%
# 20%-40%  = 80%
# 40%-60%  = 60%
# 60%-80%  = 40%
# 80%-100% = 20%

scoreboard players set #knockback_falloff knockback_scale 200

execute if score #knockback_distance knockback_distance <= #kb_80 knockback_scale run scoreboard players set #knockback_falloff knockback_scale 400

execute if score #knockback_distance knockback_distance <= #kb_60 knockback_scale run scoreboard players set #knockback_falloff knockback_scale 600

execute if score #knockback_distance knockback_distance <= #kb_40 knockback_scale run scoreboard players set #knockback_falloff knockback_scale 800

execute if score #knockback_distance knockback_distance <= #kb_20 knockback_scale run scoreboard players set #knockback_falloff knockback_scale 1000

# ------------------------------------------------------------
# APPLY FALLOFF TO MAGNITUDE
# ------------------------------------------------------------

scoreboard players operation #knockback_magnitude knockback_scale *= #knockback_falloff knockback_scale
scoreboard players operation #knockback_magnitude knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# VECTOR NORMALIZATION
#
# Each component:
#
# component / distance
#
# Both component and distance are x1000.
# The resulting ratio is then restored to x1000.
# ------------------------------------------------------------

# ------------------------------------------------------------
# X
# ------------------------------------------------------------

scoreboard players operation #knockback_vx knockback_scale = #knockback_dx knockback_dx
scoreboard players operation #knockback_vx knockback_scale *= #scale_1000 knockback_scale
scoreboard players operation #knockback_vx knockback_scale /= #knockback_distance_root knockback_scale

# ------------------------------------------------------------
# Y
# ------------------------------------------------------------

scoreboard players operation #knockback_vy knockback_scale = #knockback_dy knockback_dy
scoreboard players operation #knockback_vy knockback_scale *= #scale_1000 knockback_scale
scoreboard players operation #knockback_vy knockback_scale /= #knockback_distance_root knockback_scale

# ------------------------------------------------------------
# Z
# ------------------------------------------------------------

scoreboard players operation #knockback_vz knockback_scale = #knockback_dz knockback_dz
scoreboard players operation #knockback_vz knockback_scale *= #scale_1000 knockback_scale
scoreboard players operation #knockback_vz knockback_scale /= #knockback_distance_root knockback_scale

# ------------------------------------------------------------
# CONVERT NORMALIZED VECTOR TO FINAL VELOCITY
# ------------------------------------------------------------

scoreboard players operation #knockback_vx knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vx knockback_scale /= #scale_1000 knockback_scale

scoreboard players operation #knockback_vy knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vy knockback_scale /= #scale_1000 knockback_scale

scoreboard players operation #knockback_vz knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vz knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# APPLY EXPLOSION UPWARD BIAS
# ------------------------------------------------------------

scoreboard players operation #knockback_vy knockback_scale += #knockback_upward_bias knockback_scale

# ------------------------------------------------------------
# APPLY KNOCKBACK
# ------------------------------------------------------------

execute store result entity @s Motion[0] double 0.001 run scoreboard players get #knockback_vx knockback_scale

execute store result entity @s Motion[1] double 0.001 run scoreboard players get #knockback_vy knockback_scale

execute store result entity @s Motion[2] double 0.001 run scoreboard players get #knockback_vz knockback_scale

tellraw @a [{"text":"[KB DEBUG] ","color":"gold"},{"selector":"@s"},{"text":" | X:"},{"score":{"name":"#debug_kb_x","objective":"debug_damage"}},{"text":" Y:"},{"score":{"name":"#debug_kb_y","objective":"debug_damage"}},{"text":" Z:"},{"score":{"name":"#debug_kb_z","objective":"debug_damage"}}]