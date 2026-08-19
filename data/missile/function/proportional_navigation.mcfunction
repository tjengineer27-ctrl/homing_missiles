# ============================================================
# HOMING MISSILE - PROPORTIONAL NAVIGATION
# ============================================================
#
# Calculates an LOS angular-rate-based PN correction.
#
# Conceptually:
#
#   a_PN ∝ N × ClosingSpeed × (omega × Vhat)
#
# where:
#
#   omega = (R × Vrel) / |R|²
#
# and:
#
#   ClosingSpeed = -(R · Vmissile) / |R|
#
# IMPORTANT:
#
# Closing speed is calculated from the missile's ACTUAL
# velocity, not from the tick-to-tick change in the guidance
# vector.
#
# Scoreboard scaling:
#
#   R       ≈ 100x
#   V       ≈ 1000x
#   Vhat    ≈ 1000x
#   omega   ≈ 1000x
#   closing ≈ 1000x
#
# ============================================================


# ============================================================
# RELATIVE TARGET MOVEMENT
# ============================================================
#
# ΔR = R(current) - R(previous)
#
# This is used to estimate relative target movement for
# the LOS angular-rate calculation.
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

scoreboard players set @s pn_closing_speed 0

scoreboard players set @s pn_range_sq 0


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
# CALCULATE APPROXIMATE LOS RANGE
# ============================================================
#
# No square-root operation exists for scoreboards.
#
# Approximation:
#
#   |R| ≈ max(|Rx|, |Ry|, |Rz|)
#
# pn_dx/dy/dz are approximately 100x block precision.
#
# ============================================================

scoreboard players set #pn_math pn_range 0


# ------------------------------------------------------------
# ABSOLUTE X
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_component = @s pn_dx

execute if score #pn_math pn_component matches ..-1 run scoreboard players operation #pn_math pn_component *= #negative_one pn_scale

execute if score #pn_math pn_component > #pn_math pn_range run scoreboard players operation #pn_math pn_range = #pn_math pn_component


# ------------------------------------------------------------
# ABSOLUTE Y
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_component = @s pn_dy

execute if score #pn_math pn_component matches ..-1 run scoreboard players operation #pn_math pn_component *= #negative_one pn_scale

execute if score #pn_math pn_component > #pn_math pn_range run scoreboard players operation #pn_math pn_range = #pn_math pn_component


# ------------------------------------------------------------
# ABSOLUTE Z
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_component = @s pn_dz

execute if score #pn_math pn_component matches ..-1 run scoreboard players operation #pn_math pn_component *= #negative_one pn_scale

execute if score #pn_math pn_component > #pn_math pn_range run scoreboard players operation #pn_math pn_range = #pn_math pn_component


# ============================================================
# CALCULATE CLOSING SPEED
# ============================================================
#
# IMPORTANT:
#
# Use the missile's ACTUAL velocity:
#
#   Vc = -(R · V) / |R|
#
# NOT:
#
#   -(R · ΔR) / |R|
#
# ΔR is still used for LOS angular rate, but it is not a
# reliable representation of the missile's actual velocity
# because guidance values are integer-truncated.
#
# Scaling:
#
#   R = 100x
#   V = 1000x
#
# Therefore:
#
#   R · V = 100,000x
#
# Dividing by R (100x):
#
#   Vc = 1000x
#
# So a missile travelling at approximately:
#
#   0.25 blocks/tick
#
# toward the target should produce approximately:
#
#   CLOSING = 250
#
# ============================================================


# ------------------------------------------------------------
# CLEAR CLOSING SPEED
# ------------------------------------------------------------

scoreboard players set @s pn_closing_speed 0


# ------------------------------------------------------------
# X COMPONENT
# ------------------------------------------------------------

scoreboard players operation @s pn_closing_speed = @s pn_dx
scoreboard players operation @s pn_closing_speed *= @s missile_vx


# ------------------------------------------------------------
# Y COMPONENT
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_component = @s pn_dy
scoreboard players operation #pn_math pn_component *= @s missile_vy

scoreboard players operation @s pn_closing_speed += #pn_math pn_component


# ------------------------------------------------------------
# Z COMPONENT
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_component = @s pn_dz
scoreboard players operation #pn_math pn_component *= @s missile_vz

scoreboard players operation @s pn_closing_speed += #pn_math pn_component


# ------------------------------------------------------------
# DIVIDE BY APPROXIMATE RANGE
# ------------------------------------------------------------

execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_closing_speed /= #pn_math pn_range


# ------------------------------------------------------------
# INVERT SIGN
# ------------------------------------------------------------
#
# Positive = closing
# Negative = opening
#
# ------------------------------------------------------------

scoreboard players operation @s pn_closing_speed *= #negative_one pn_scale


# ------------------------------------------------------------
# DO NOT ALLOW NEGATIVE CLOSING SPEED
# ------------------------------------------------------------

execute if score @s pn_closing_speed matches ..-1 run scoreboard players set @s pn_closing_speed 0


# ============================================================
# CALCULATE R × ΔR
# ============================================================
#
# This is used for LOS angular rate.
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
# We approximate Vrel using ΔR.
#
# Rate scale:
#
#   #pn_rate_scale = 1000
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
# Approximation:
#
#   Vhat ≈ V / max(|Vx|, |Vy|, |Vz|)
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


# ============================================================
# LIMIT MISSILE SPEED
# ============================================================
#
# 250 / 1000 = 0.25 blocks/tick
#
# ============================================================

execute if score @s pn_speed_scale matches 251.. run scoreboard players set @s pn_speed_scale 250


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
#   omega × Vhat
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
# APPLY CLOSING SPEED
# ============================================================
#
# At this point:
#
#   pn_los ≈ omega × 1000
#   pn_dir ≈ Vhat × 1000
#
# Therefore their cross product is approximately 1,000,000x.
#
# Multiplying by closing speed adds another 1000x.
#
# We therefore divide by:
#
#   1,000,000
#
# to return the result to approximately velocity-scale
# precision before applying the navigation gain.
#
# ============================================================

scoreboard players operation @s pn_accel_x *= @s pn_closing_speed
scoreboard players operation @s pn_accel_x /= #pn_output_scale pn_scale

scoreboard players operation @s pn_accel_y *= @s pn_closing_speed
scoreboard players operation @s pn_accel_y /= #pn_output_scale pn_scale

scoreboard players operation @s pn_accel_z *= @s pn_closing_speed
scoreboard players operation @s pn_accel_z /= #pn_output_scale pn_scale


# ============================================================
# NAVIGATION GAIN / TURN SCALE
# ============================================================
#
# #pn_navigation_gain = 4000
# #pn_turn_scale     = 5000
#
# This gives an effective gain of approximately:
#
#   4000 / 5000 = 0.8
#
# Smaller #pn_turn_scale values produce stronger steering.
#
# ============================================================

scoreboard players operation @s pn_accel_x *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_x /= #pn_turn_scale pn_scale

scoreboard players operation @s pn_accel_y *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_y /= #pn_turn_scale pn_scale

scoreboard players operation @s pn_accel_z *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_z /= #pn_turn_scale pn_scale


# ============================================================
# PN DEBUG
# ============================================================

function missile:pn_debug