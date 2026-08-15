# Proportional Navigation — Revised Precision

# ============================================================
# HOMING MISSILE - PROPORTIONAL NAVIGATION
# ============================================================
#
# Calculates an LOS angular-rate-based PN correction.
#
# This function DOES NOT modify missile movement yet.
#
# Important:
#   Minecraft scoreboards use integer arithmetic.
#
#   Therefore the LOS angular-rate calculation is deliberately
#   scaled by #pn_rate_scale before division.
#
#   omega_scaled =
#       (R × ΔR) × PN_RATE_SCALE / |R|²
#
# ============================================================


# ============================================================
# RELATIVE TARGET MOVEMENT
# ============================================================
#
# ΔR = R(current) - R(previous)
#
# ============================================================

scoreboard players operation @s guidance_rel_vx = @s guidance_dx
scoreboard players operation @s guidance_rel_vx -= @s guidance_prev_dx

scoreboard players operation @s guidance_rel_vy = @s guidance_dy
scoreboard players operation @s guidance_rel_vy -= @s guidance_prev_dy

scoreboard players operation @s guidance_rel_vz = @s guidance_dz
scoreboard players operation @s guidance_rel_vz -= @s guidance_prev_dz


# ============================================================
# CLEAR PREVIOUS PN VALUES
# ============================================================

scoreboard players set @s pn_los_x 0
scoreboard players set @s pn_los_y 0
scoreboard players set @s pn_los_z 0

scoreboard players set @s pn_accel_x 0
scoreboard players set @s pn_accel_y 0
scoreboard players set @s pn_accel_z 0


# ============================================================
# CALCULATE LOS RANGE SQUARED
# ============================================================
#
# |R|² = Rx² + Ry² + Rz²
#
# ============================================================

scoreboard players operation @s pn_range_sq = @s pn_dx
scoreboard players operation @s pn_range_sq *= @s pn_dx

scoreboard players operation #pn_math pn_scale = @s pn_dy
scoreboard players operation #pn_math pn_scale *= @s pn_dy
scoreboard players operation @s pn_range_sq += #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_dz
scoreboard players operation #pn_math pn_scale *= @s pn_dz
scoreboard players operation @s pn_range_sq += #pn_math pn_scale


# ============================================================
# CALCULATE R × ΔR
# ============================================================
#
# X = Ry*ΔRz - Rz*ΔRy
# Y = Rz*ΔRx - Rx*ΔRz
# Z = Rx*ΔRy - Ry*ΔRx
#
# ============================================================

# ------------------------------------------------------------
# X
# ------------------------------------------------------------

scoreboard players operation @s pn_los_x = @s pn_dy
scoreboard players operation @s pn_los_x *= @s guidance_rel_vz

scoreboard players operation #pn_math pn_scale = @s pn_dz
scoreboard players operation #pn_math pn_scale *= @s guidance_rel_vy

scoreboard players operation @s pn_los_x -= #pn_math pn_scale


# ------------------------------------------------------------
# Y
# ------------------------------------------------------------

scoreboard players operation @s pn_los_y = @s pn_dz
scoreboard players operation @s pn_los_y *= @s guidance_rel_vx

scoreboard players operation #pn_math pn_scale = @s pn_dx
scoreboard players operation #pn_math pn_scale *= @s guidance_rel_vz

scoreboard players operation @s pn_los_y -= #pn_math pn_scale


# ------------------------------------------------------------
# Z
# ------------------------------------------------------------

scoreboard players operation @s pn_los_z = @s pn_dx
scoreboard players operation @s pn_los_z *= @s guidance_rel_vy

scoreboard players operation #pn_math pn_scale = @s pn_dy
scoreboard players operation #pn_math pn_scale *= @s guidance_rel_vx

scoreboard players operation @s pn_los_z -= #pn_math pn_scale


# ============================================================
# CONVERT R × ΔR INTO SCALED LOS ANGULAR RATE
# ============================================================
#
# omega = (R × Vrel) / |R|²
#
# We approximate Vrel with ΔR.
#
# Because scoreboard division truncates integers, multiply
# FIRST by #pn_rate_scale.
#
# omega_scaled =
#     (R × ΔR) × PN_RATE_SCALE / |R|²
#
# ============================================================

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_x *= #pn_rate_scale pn_scale

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_y *= #pn_rate_scale pn_scale

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_z *= #pn_rate_scale pn_scale

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_x /= @s pn_range_sq

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_y /= @s pn_range_sq

execute if score @s pn_range_sq matches 1.. run scoreboard players operation @s pn_los_z /= @s pn_range_sq


# ============================================================
# NORMALIZE MISSILE VELOCITY
# ============================================================
#
# Exact:
#
#   Vhat = V / |V|
#
# Scoreboards have no square-root operation, so use:
#
#   Vhat ≈ V / max(|Vx|, |Vy|, |Vz|)
#
# The result is represented at 1000x precision.
#
# ============================================================

scoreboard players set @s pn_speed_scale 0


# ------------------------------------------------------------
# ABSOLUTE X
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s missile_vx

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_speed_scale run scoreboard players operation @s pn_speed_scale = #pn_math pn_scale


# ------------------------------------------------------------
# ABSOLUTE Y
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s missile_vy

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_speed_scale run scoreboard players operation @s pn_speed_scale = #pn_math pn_scale


# ------------------------------------------------------------
# ABSOLUTE Z
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s missile_vz

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_speed_scale run scoreboard players operation @s pn_speed_scale = #pn_math pn_scale


# ------------------------------------------------------------
# CLEAR NORMALIZED DIRECTION
# ------------------------------------------------------------

scoreboard players set @s pn_dir_x 0
scoreboard players set @s pn_dir_y 0
scoreboard players set @s pn_dir_z 0


# ------------------------------------------------------------
# NORMALIZE VELOCITY
# ------------------------------------------------------------

execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_x = @s missile_vx
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_x *= #pn_direction_scale pn_scale
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_x /= @s pn_speed_scale

execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_y = @s missile_vy
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_y *= #pn_direction_scale pn_scale
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_y /= @s pn_speed_scale

execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_z = @s missile_vz
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_z *= #pn_direction_scale pn_scale
execute if score @s pn_speed_scale matches 1.. run scoreboard players operation @s pn_dir_z /= @s pn_speed_scale


# ============================================================
# CALCULATE PN TURNING COMPONENT
# ============================================================
#
# Proper PN relationship:
#
#   a_PN ∝ omega × Vhat
#
# ============================================================


# ------------------------------------------------------------
# X
# ------------------------------------------------------------

scoreboard players operation @s pn_accel_x = @s pn_los_y
scoreboard players operation @s pn_accel_x *= @s pn_dir_z

scoreboard players operation #pn_math pn_scale = @s pn_los_z
scoreboard players operation #pn_math pn_scale *= @s pn_dir_y

scoreboard players operation @s pn_accel_x -= #pn_math pn_scale


# ------------------------------------------------------------
# Y
# ------------------------------------------------------------

scoreboard players operation @s pn_accel_y = @s pn_los_z
scoreboard players operation @s pn_accel_y *= @s pn_dir_x

scoreboard players operation #pn_math pn_scale = @s pn_los_x
scoreboard players operation #pn_math pn_scale *= @s pn_dir_z

scoreboard players operation @s pn_accel_y -= #pn_math pn_scale


# ------------------------------------------------------------
# Z
# ------------------------------------------------------------

scoreboard players operation @s pn_accel_z = @s pn_los_x
scoreboard players operation @s pn_accel_z *= @s pn_dir_y

scoreboard players operation #pn_math pn_scale = @s pn_los_y
scoreboard players operation #pn_math pn_scale *= @s pn_dir_x

scoreboard players operation @s pn_accel_z -= #pn_math pn_scale


# ============================================================
# APPLY NAVIGATION GAIN
# ============================================================
#
# pn_los is represented at PN_RATE_SCALE precision.
# pn_dir is represented at PN_DIRECTION_SCALE precision.
#
# Therefore the cross product is scaled by:
#
#   PN_RATE_SCALE × PN_DIRECTION_SCALE
#
# We compensate for the direction scale here.
#
# ============================================================

scoreboard players operation @s pn_accel_x *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_x /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_accel_y *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_y /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_accel_z *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_z /= #pn_direction_scale pn_scale


# ============================================================
# PN DEBUG
# ============================================================

function missile:pn_debug