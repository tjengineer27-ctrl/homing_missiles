# ============================================================
# HOMING MISSILE - ACTIVE PN MOVEMENT
# ============================================================
#
# @s = missile_controller
#
# The controller is the actual missile.
#
# The tracker and firework rocket follow the controller through
# the existing controller architecture.
#
# PN provides:
#
#   pn_dir_x/y/z
#       Current normalized missile direction
#       approximately 1000x precision.
#
#   pn_accel_x/y/z
#       PN steering correction.
#
#   pn_speed_scale
#       Current missile speed represented in scoreboard units.
#
# This function:
#
#   1. Copies the current direction.
#   2. Applies a small PN correction.
#   3. Normalizes the new direction.
#   4. Restores the current missile speed.
#   5. Converts the movement to decimal block coordinates.
#   6. Moves the controller.
#   7. Stores the new velocity.
#
# ============================================================


# ============================================================
# STEP 1 — COPY CURRENT NORMALIZED DIRECTION
# ============================================================

scoreboard players operation @s pn_new_x = @s pn_dir_x
scoreboard players operation @s pn_new_y = @s pn_dir_y
scoreboard players operation @s pn_new_z = @s pn_dir_z


# ============================================================
# STEP 2 — APPLY PN CORRECTION
# ============================================================
#
# pn_accel is reduced before being added to the direction.
#
# #pn_turn_scale controls steering strength.
#
# Current value:
#
#   #pn_turn_scale = 100
#
# ============================================================

scoreboard players operation #pn_math pn_scale = @s pn_accel_x
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_x += #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_accel_y
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_y += #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_accel_z
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_z += #pn_math pn_scale


# ============================================================
# STEP 3 — FIND LARGEST ABSOLUTE COMPONENT
# ============================================================

scoreboard players set @s pn_new_scale 0


# ------------------------------------------------------------
# ABSOLUTE X
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s pn_new_x

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale


# ------------------------------------------------------------
# ABSOLUTE Y
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s pn_new_y

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale


# ------------------------------------------------------------
# ABSOLUTE Z
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s pn_new_z

execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale

execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale


# ============================================================
# STEP 4 — NORMALIZE NEW DIRECTION
# ============================================================
#
# new_direction ≈ new_vector / max_component
#
# Stored at 1000x precision.
#
# ============================================================

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_x *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_x /= @s pn_new_scale

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_y *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_y /= @s pn_new_scale

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_z *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_z /= @s pn_new_scale


# ============================================================
# STEP 5 — RESTORE CURRENT MISSILE SPEED
# ============================================================
#
# velocity =
#
#   normalized_direction × current_speed
#
# pn_new_*      = direction × 1000
# pn_speed_scale = speed × 1000
#
# Therefore:
#
#   movement = direction × speed
#
# ============================================================

scoreboard players operation @s pn_move_x = @s pn_new_x
scoreboard players operation @s pn_move_x *= @s pn_speed_scale
scoreboard players operation @s pn_move_x /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_move_y = @s pn_new_y
scoreboard players operation @s pn_move_y *= @s pn_speed_scale
scoreboard players operation @s pn_move_y /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_move_z = @s pn_new_z
scoreboard players operation @s pn_move_z *= @s pn_speed_scale
scoreboard players operation @s pn_move_z /= #pn_direction_scale pn_scale


# ============================================================
# STEP 6 — PREPARE DECIMAL MOVEMENT
# ============================================================
#
# Example:
#
#   pn_move_x = 237
#
# becomes:
#
#   0.237 blocks/tick
#
# ============================================================

execute store result storage missile:movement dx double 0.001 run scoreboard players get @s pn_move_x

execute store result storage missile:movement dy double 0.001 run scoreboard players get @s pn_move_y

execute store result storage missile:movement dz double 0.001 run scoreboard players get @s pn_move_z


# ============================================================
# STEP 7 — MOVE CONTROLLER
# ============================================================
#
# The controller is the missile.
#
# Tracker and firework follow the controller elsewhere.
#
# ============================================================

$tp @s ~$(dx) ~$(dy) ~$(dz)


# ============================================================
# STEP 8 — SAVE NEW VELOCITY
# ============================================================

scoreboard players operation @s missile_vx = @s pn_move_x
scoreboard players operation @s missile_vy = @s pn_move_y
scoreboard players operation @s missile_vz = @s pn_move_z


# ============================================================
# STEP 9 — SAVE NEW DIRECTION
# ============================================================
#
# The next PN cycle should begin with the direction that was
# actually used for this movement.
#
# ============================================================

scoreboard players operation @s pn_dir_x = @s pn_new_x
scoreboard players operation @s pn_dir_y = @s pn_new_y
scoreboard players operation @s pn_dir_z = @s pn_new_z


# ============================================================
# CLEAR MOVEMENT STATE
# ============================================================

scoreboard players set @s pn_move_active 0