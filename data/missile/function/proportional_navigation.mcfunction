# ============================================================
# HOMING MISSILE - PROPORTIONAL NAVIGATION
# ============================================================
#
# Calculates proportional-navigation guidance with a pursuit
# fallback.
#
# Normal PN:
#
#   a_PN ∝ N × Vclose × (omega × Vhat)
#
# where:
#
#   omega = (R × Vrel) / |R|²
#
# The missile also receives a pursuit correction when closing
# velocity is low or negative.
#
# This prevents PN from completely shutting off when the
# missile is temporarily opening from a moving target.
#
# ============================================================


# ============================================================
# RELATIVE TARGET MOVEMENT
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
scoreboard players set @s pn_effective_closing 0

scoreboard players set @s pn_los_dir_x 0
scoreboard players set @s pn_los_dir_y 0
scoreboard players set @s pn_los_dir_z 0

scoreboard players set @s pn_pursuit_x 0
scoreboard players set @s pn_pursuit_y 0
scoreboard players set @s pn_pursuit_z 0


# ============================================================
# CALCULATE LOS RANGE SQUARED
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
# |R| ≈ max(|Rx|, |Ry|, |Rz|)
#
# pn_dx / pn_dy / pn_dz use approximately 100x block scale.
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
# NORMALIZE LOS DIRECTION
# ============================================================
#
# LOS direction:
#
#   Rhat ≈ R / max(|R|)
#
# Result is scaled to 1000.
#
# ============================================================

execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_x = @s pn_dx
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_x *= #pn_direction_scale pn_scale
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_x /= #pn_math pn_range

execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_y = @s pn_dy
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_y *= #pn_direction_scale pn_scale
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_y /= #pn_math pn_range

execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_z = @s pn_dz
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_z *= #pn_direction_scale pn_scale
execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_los_dir_z /= #pn_math pn_range


# ============================================================
# CALCULATE SIGNED CLOSING SPEED
# ============================================================
#
# Vclose = -(R · ΔR) / |R|
#
# IMPORTANT:
# We deliberately DO NOT clamp negative values here.
#
# pn_closing_speed is now a signed diagnostic:
#
#   positive = closing
#   zero     = perpendicular
#   negative = opening
#
# ============================================================

scoreboard players operation @s pn_closing_speed = @s pn_dx
scoreboard players operation @s pn_closing_speed *= @s guidance_rel_vx

scoreboard players operation #pn_math pn_component = @s pn_dy
scoreboard players operation #pn_math pn_component *= @s guidance_rel_vy
scoreboard players operation @s pn_closing_speed += #pn_math pn_component

scoreboard players operation #pn_math pn_component = @s pn_dz
scoreboard players operation #pn_math pn_component *= @s guidance_rel_vz
scoreboard players operation @s pn_closing_speed += #pn_math pn_component

scoreboard players operation @s pn_closing_speed *= #negative_one pn_scale

execute if score #pn_math pn_range matches 1.. run scoreboard players operation @s pn_closing_speed /= #pn_math pn_range


# ============================================================
# EFFECTIVE CLOSING SPEED
# ============================================================
#
# PN needs a positive magnitude to remain responsive.
#
# If actual closing speed is positive:
#
#   effective = actual closing speed
#
# If actual closing speed is zero or negative:
#
#   effective = minimum guidance speed
#
# This prevents:
#
#   CLOSING = 0
#       ↓
#   PN ACCEL = 0
#
# from permanently disabling guidance.
#
# ============================================================

scoreboard players operation @s pn_effective_closing = @s pn_closing_speed

execute if score @s pn_effective_closing matches ..99 run scoreboard players operation @s pn_effective_closing = #pn_min_closing pn_scale


# ============================================================
# CALCULATE R × ΔR
# ============================================================
#
# omega numerator:
#
#   X = Ry*ΔRz - Rz*ΔRy
#   Y = Rz*ΔRx - Rx*ΔRz
#   Z = Rx*ΔRy - Ry*ΔRx
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
# Vhat ≈ V / max(|Vx|, |Vy|, |Vz|)
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

execute if score @s pn_speed_scale matches 251.. run scoreboard players set @s pn_speed_scale 250


# ============================================================
# CLEAR NORMALIZED DIRECTION
# ============================================================

scoreboard players set @s pn_dir_x 0
scoreboard players set @s pn_dir_y 0
scoreboard players set @s pn_dir_z 0


# ============================================================
# NORMALIZE VELOCITY
# ============================================================

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
# omega × Vhat
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
# APPLY EFFECTIVE CLOSING SPEED TO PN
# ============================================================

scoreboard players operation @s pn_accel_x *= @s pn_effective_closing
scoreboard players operation @s pn_accel_x /= #pn_closing_scale pn_scale

scoreboard players operation @s pn_accel_y *= @s pn_effective_closing
scoreboard players operation @s pn_accel_y /= #pn_closing_scale pn_scale

scoreboard players operation @s pn_accel_z *= @s pn_effective_closing
scoreboard players operation @s pn_accel_z /= #pn_closing_scale pn_scale


# ============================================================
# APPLY NAVIGATION GAIN TO PN
# ============================================================

scoreboard players operation @s pn_accel_x *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_x /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_accel_y *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_y /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_accel_z *= #pn_navigation_gain pn_scale
scoreboard players operation @s pn_accel_z /= #pn_direction_scale pn_scale


# ============================================================
# PURSUIT CORRECTION
# ============================================================
#
# When PN is operating normally, this is deliberately modest.
#
# When the missile is opening:
#
#   Rhat - Vhat
#
# produces a correction toward the target.
#
# This prevents a moving target from causing the missile to
# become permanently ballistic.
#
# ============================================================


# ------------------------------------------------------------
# X
# ------------------------------------------------------------

scoreboard players operation @s pn_pursuit_x = @s pn_los_dir_x
scoreboard players operation @s pn_pursuit_x -= @s pn_dir_x


# ------------------------------------------------------------
# Y
# ------------------------------------------------------------

scoreboard players operation @s pn_pursuit_y = @s pn_los_dir_y
scoreboard players operation @s pn_pursuit_y -= @s pn_dir_y


# ------------------------------------------------------------
# Z
# ------------------------------------------------------------

scoreboard players operation @s pn_pursuit_z = @s pn_los_dir_z
scoreboard players operation @s pn_pursuit_z -= @s pn_dir_z


# ============================================================
# SCALE PURSUIT CORRECTION
# ============================================================
#
# Pursuit should become stronger as closing becomes worse.
#
# We use the minimum-closing floor to avoid enormous values.
#
# The fallback is intentionally modest so normal PN remains
# the dominant interception mechanism.
#
# ============================================================

execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_x *= #pn_pursuit_gain pn_scale
execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_x /= #pn_direction_scale pn_scale

execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_y *= #pn_pursuit_gain pn_scale
execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_y /= #pn_direction_scale pn_scale

execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_z *= #pn_pursuit_gain pn_scale
execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_pursuit_z /= #pn_direction_scale pn_scale


# ============================================================
# ADD PURSUIT TO PN ACCELERATION
# ============================================================

execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_accel_x += @s pn_pursuit_x
execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_accel_y += @s pn_pursuit_y
execute if score @s pn_closing_speed matches ..-1 run scoreboard players operation @s pn_accel_z += @s pn_pursuit_z


# ============================================================
# PN DEBUG
# ============================================================

function missile:pn_debug