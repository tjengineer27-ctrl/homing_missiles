# ============================================================
# HOMING MISSILE - KNOCKBACK TARGET
# ============================================================

# say KNOCKBACK_TARGET FUNCTION ENTERED

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
# CALCULATE 3D DISTANCE SQUARED
#
# Coordinates are x1000.
# Therefore distance² is x1,000,000.
#
# This remains the distance used for AOE falloff.
# ------------------------------------------------------------

scoreboard players operation #knockback_distance knockback_distance = #knockback_dx knockback_dx
scoreboard players operation #knockback_distance knockback_distance *= #knockback_dx knockback_dx

scoreboard players operation #knockback_math knockback_math = #knockback_dy knockback_dy
scoreboard players operation #knockback_math knockback_math *= #knockback_dy knockback_math
scoreboard players operation #knockback_distance knockback_distance += #knockback_math knockback_math

scoreboard players operation #knockback_math knockback_math = #knockback_dz knockback_dz
scoreboard players operation #knockback_math knockback_math *= #knockback_dz knockback_math
scoreboard players operation #knockback_distance knockback_distance += #knockback_math knockback_math

# ------------------------------------------------------------
# CALCULATE ACTUAL 3D DISTANCE
#
# Newton-Raphson integer square root.
#
# distance² = x1,000,000
# distance root = x1,000
# ------------------------------------------------------------

# ------------------------------------------------------------
# INITIAL APPROXIMATION
# ------------------------------------------------------------

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

# ============================================================
# DEBUG - 3D VECTOR / DISTANCE
# ============================================================

# tellraw @a [{"text":"[KB MATH] DX: ","color":"yellow"},{"score":{"name":"#knockback_dx","objective":"knockback_dx"}},{"text":" DY: ","color":"yellow"},{"score":{"name":"#knockback_dy","objective":"knockback_dy"}},{"text":" DZ: ","color":"yellow"},{"score":{"name":"#knockback_dz","objective":"knockback_dz"}}]

# tellraw @a [{"text":"[KB MATH] DIST²: ","color":"aqua"},{"score":{"name":"#knockback_distance","objective":"knockback_distance"}},{"text":" ROOT: ","color":"aqua"},{"score":{"name":"#knockback_distance_root","objective":"knockback_scale"}}]

# ============================================================
# CALCULATE HORIZONTAL XZ DISTANCE²
#
# Only X and Z are used here.
#
# This distance is used ONLY to normalize the horizontal
# knockback direction.
# ============================================================

scoreboard players operation #knockback_horizontal_distance knockback_distance = #knockback_dx knockback_dx
scoreboard players operation #knockback_horizontal_distance knockback_distance *= #knockback_dx knockback_dx

scoreboard players operation #knockback_math knockback_math = #knockback_dz knockback_dz
scoreboard players operation #knockback_math knockback_math *= #knockback_dz knockback_math

scoreboard players operation #knockback_horizontal_distance knockback_distance += #knockback_math knockback_math

# ------------------------------------------------------------
# CALCULATE HORIZONTAL DISTANCE ROOT
#
# horizontal distance² = x1,000,000
# horizontal distance root = x1,000
# ------------------------------------------------------------

# ------------------------------------------------------------
# INITIAL APPROXIMATION
# ------------------------------------------------------------

scoreboard players operation #knockback_horizontal_root knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# ITERATION 1
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_horizontal_root knockback_scale

scoreboard players operation #knockback_horizontal_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 2
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_horizontal_root knockback_scale

scoreboard players operation #knockback_horizontal_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 3
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_horizontal_root knockback_scale

scoreboard players operation #knockback_horizontal_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 4
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_horizontal_root knockback_scale

scoreboard players operation #knockback_horizontal_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_2 knockback_scale

# ------------------------------------------------------------
# ITERATION 5
# ------------------------------------------------------------

scoreboard players operation #knockback_math knockback_scale = #knockback_horizontal_distance knockback_distance
scoreboard players operation #knockback_math knockback_scale /= #knockback_horizontal_root knockback_scale

scoreboard players operation #knockback_horizontal_root knockback_scale += #knockback_math knockback_scale
scoreboard players operation #knockback_horizontal_root knockback_scale /= #scale_2 knockback_scale

# ============================================================
# DEBUG - HORIZONTAL DISTANCE
# ============================================================

# tellraw @a [{"text":"[KB HORIZONTAL] DIST²: ","color":"aqua"},{"score":{"name":"#knockback_horizontal_distance","objective":"knockback_distance"}},{"text":" ROOT: ","color":"aqua"},{"score":{"name":"#knockback_horizontal_root","objective":"knockback_scale"}}]

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

scoreboard players operation #active_controller controller_id = @s aoe_controller_id

execute as @e[type=minecraft:marker,tag=missile_controller] if score @s controller_id = #active_controller controller_id run scoreboard players operation #base_knockback knockback_scale = #active_yield_knockback knockback_scale

# ------------------------------------------------------------
# DEBUG - CONTROLLER KNOCKBACK VALUE
# ------------------------------------------------------------

# tellraw @a [{"text":"[Knockback Debug] Base KB = ","color":"gold"},{"score":{"name":"#base_knockback","objective":"knockback_scale"},"color":"aqua"}]

scoreboard players operation #knockback_magnitude knockback_scale = #base_knockback knockback_scale

# ------------------------------------------------------------
# APPLY YIELD MULTIPLIER
# ------------------------------------------------------------

scoreboard players operation #knockback_magnitude knockback_scale *= #knockback_multiplier knockback_scale
scoreboard players operation #knockback_magnitude knockback_scale /= #scale_1000 knockback_scale

# tellraw @a [{"text":"[KB MATH] AFTER YIELD = ","color":"gold"},{"score":{"name":"#knockback_magnitude","objective":"knockback_scale"},"color":"aqua"}]

# ------------------------------------------------------------
# CALCULATE DYNAMIC AOE RADIUS²
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller] if score @s controller_id = #active_controller controller_id run scoreboard players operation #active_aoe_radius aoe_radius_squared = @s yield_radius

scoreboard players operation #active_aoe_radius aoe_radius_squared *= #scale_1000 knockback_scale
scoreboard players operation #active_aoe_radius aoe_radius_squared *= #active_aoe_radius aoe_radius_squared

# tellraw @a [{"text":"[KB RADIUS] yield_radius: ","color":"yellow"},{"score":{"name":"#active_aoe_radius","objective":"aoe_radius_squared"}},{"text":" | AOE scale: ","color":"white"},{"score":{"name":"#aoe_scale","objective":"aoe_radius_squared"}},{"text":" | Active radius²: ","color":"aqua"},{"score":{"name":"#active_aoe_radius","objective":"aoe_radius_squared"}}]

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
scoreboard players operation #kb_20 knockback_scale /= #scale_1000 knockback_scale

scoreboard players set #knockback_math knockback_scale 40
scoreboard players operation #kb_20 knockback_scale *= #knockback_math knockback_scale

# ------------------------------------------------------------
# 40% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_40 knockback_scale = #active_aoe_radius aoe_radius_squared
scoreboard players operation #kb_40 knockback_scale /= #scale_1000 knockback_scale

scoreboard players set #knockback_math knockback_scale 160
scoreboard players operation #kb_40 knockback_scale *= #knockback_math knockback_scale

# ------------------------------------------------------------
# 60% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_60 knockback_scale = #active_aoe_radius aoe_radius_squared
scoreboard players operation #kb_60 knockback_scale /= #scale_1000 knockback_scale

scoreboard players set #knockback_math knockback_scale 360
scoreboard players operation #kb_60 knockback_scale *= #knockback_math knockback_scale

# ------------------------------------------------------------
# 80% RADIUS²
# ------------------------------------------------------------

scoreboard players operation #kb_80 knockback_scale = #active_aoe_radius aoe_radius_squared
scoreboard players operation #kb_80 knockback_scale /= #scale_1000 knockback_scale

scoreboard players set #knockback_math knockback_scale 640
scoreboard players operation #kb_80 knockback_scale *= #knockback_math knockback_scale

# tellraw @a [{"text":"[KB THRESHOLDS] R²: ","color":"gold"},{"score":{"name":"#active_aoe_radius","objective":"aoe_radius_squared"}},{"text":" | KB20: ","color":"white"},{"score":{"name":"#kb_20","objective":"knockback_scale"}},{"text":" | KB40: ","color":"white"},{"score":{"name":"#kb_40","objective":"knockback_scale"}},{"text":" | KB60: ","color":"white"},{"score":{"name":"#kb_60","objective":"knockback_scale"}},{"text":" | KB80: ","color":"white"},{"score":{"name":"#kb_80","objective":"knockback_scale"}}]

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

# ============================================================
# DEBUG - FALLOFF RESULT
# ============================================================

# tellraw @a [{"text":"[KB MATH] MAGNITUDE: ","color":"green"},{"score":{"name":"#knockback_magnitude","objective":"knockback_scale"}},{"text":" FALLOFF: ","color":"green"},{"score":{"name":"#knockback_falloff","objective":"knockback_scale"}}]

# tellraw @a [{"text":"[KB MATH] KB20: ","color":"white"},{"score":{"name":"#kb_20","objective":"knockback_scale"}},{"text":" KB40: ","color":"white"},{"score":{"name":"#kb_40","objective":"knockback_scale"}},{"text":" KB60: ","color":"white"},{"score":{"name":"#kb_60","objective":"knockback_scale"}},{"text":" KB80: ","color":"white"},{"score":{"name":"#kb_80","objective":"knockback_scale"}}]

# ============================================================
# HORIZONTAL VECTOR NORMALIZATION
#
# X and Z determine horizontal direction.
# Y is intentionally NOT derived from DY.
#
# Both DX/DZ and horizontal root are x1000.
# The resulting normalized components are restored to x1000.
# ============================================================

# ------------------------------------------------------------
# X
# ------------------------------------------------------------

scoreboard players operation #knockback_vx knockback_scale = #knockback_dx knockback_dx
scoreboard players operation #knockback_vx knockback_scale *= #scale_1000 knockback_scale
scoreboard players operation #knockback_vx knockback_scale /= #knockback_horizontal_root knockback_scale

# ------------------------------------------------------------
# Z
# ------------------------------------------------------------

scoreboard players operation #knockback_vz knockback_scale = #knockback_dz knockback_dz
scoreboard players operation #knockback_vz knockback_scale *= #scale_1000 knockback_scale
scoreboard players operation #knockback_vz knockback_scale /= #knockback_horizontal_root knockback_scale

# ------------------------------------------------------------
# Y
#
# Do NOT normalize DY.
# Use the configured upward launch bias directly.
# ------------------------------------------------------------

scoreboard players operation #knockback_vy knockback_scale = #knockback_upward_bias knockback_scale

# ============================================================
# DEBUG - NORMALIZED HORIZONTAL VECTOR
# ============================================================

# tellraw @a [{"text":"[KB VECTOR] VX: ","color":"gold"},{"score":{"name":"#knockback_vx","objective":"knockback_scale"}},{"text":" VY: ","color":"gold"},{"score":{"name":"#knockback_vy","objective":"knockback_scale"}},{"text":" VZ: ","color":"gold"},{"score":{"name":"#knockback_vz","objective":"knockback_scale"}}]

# ------------------------------------------------------------
# CONVERT NORMALIZED HORIZONTAL VECTOR TO FINAL VELOCITY
# ------------------------------------------------------------

scoreboard players operation #knockback_vx knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vx knockback_scale /= #scale_1000 knockback_scale

scoreboard players operation #knockback_vz knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vz knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# CONVERT UPWARD BIAS TO FINAL VELOCITY
#
# Upward bias is already an x1000 velocity value.
# Multiply it by the same magnitude/falloff so the launch
# scales with explosion strength.
# ------------------------------------------------------------

scoreboard players operation #knockback_vy knockback_scale *= #knockback_magnitude knockback_scale
scoreboard players operation #knockback_vy knockback_scale /= #scale_1000 knockback_scale

# ============================================================
# DEBUG - FINAL KNOCKBACK VECTOR
# ============================================================

# tellraw @a [{"text":"[KB FINAL] Target: ","color":"gold"},{"selector":"@s"},{"text":" | VX=","color":"white"},{"score":{"name":"#knockback_vx","objective":"knockback_scale"},"color":"aqua"},{"text":" VY=","color":"white"},{"score":{"name":"#knockback_vy","objective":"knockback_scale"},"color":"aqua"},{"text":" VZ=","color":"white"},{"score":{"name":"#knockback_vz","objective":"knockback_scale"},"color":"aqua"},{"text":" | MAG=","color":"white"},{"score":{"name":"#knockback_magnitude","objective":"knockback_scale"},"color":"green"}]

# ------------------------------------------------------------
# APPLY KNOCKBACK
# ------------------------------------------------------------

execute store result entity @s Motion[0] double 0.001 run scoreboard players get #knockback_vx knockback_scale

execute store result entity @s Motion[1] double 0.001 run scoreboard players get #knockback_vy knockback_scale

execute store result entity @s Motion[2] double 0.001 run scoreboard players get #knockback_vz knockback_scale

data get entity @s Motion