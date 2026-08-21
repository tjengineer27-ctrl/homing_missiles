# ============================================================
# HOMING MISSILE - ACTIVE PN MOVEMENT DEBUG
# ============================================================

# ============================================================
# HOMING MISSILE - ACTIVE PN MOVEMENT DEBUG
# ============================================================

# tellraw @a [{"text":"[ACTIVE MOVEMENT ENTERED] ","color":"green"},{"text":"Controller ","color":"yellow"},{"score":{"name":"@s","objective":"controller_id"}}]

# ------------------------------------------------------------
# COPY CURRENT NORMALIZED DIRECTION
# ------------------------------------------------------------

scoreboard players operation @s pn_new_x = @s pn_dir_x
scoreboard players operation @s pn_new_y = @s pn_dir_y
scoreboard players operation @s pn_new_z = @s pn_dir_z


# ------------------------------------------------------------
# APPLY FORWARD MOTION RETENTION
# ------------------------------------------------------------
#
# Preserve a portion of the missile's existing heading before
# applying the PN steering correction.
#
# #pn_forward_retention:
#
#     1000 = 100% forward retention
#      750 = 75% forward retention
#      500 = 50% forward retention
#
# This prevents the PN correction from completely replacing
# the missile's forward flight direction.
#
# ------------------------------------------------------------

scoreboard players operation @s pn_new_x *= #pn_forward_retention pn_scale
scoreboard players operation @s pn_new_x /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_new_y *= #pn_forward_retention pn_scale
scoreboard players operation @s pn_new_y /= #pn_direction_scale pn_scale

scoreboard players operation @s pn_new_z *= #pn_forward_retention pn_scale
scoreboard players operation @s pn_new_z /= #pn_direction_scale pn_scale


# ------------------------------------------------------------
# APPLY PN CORRECTION WITH TURN-RATE LIMIT
# ------------------------------------------------------------
#
# Start from the missile's current heading.
#
# pn_accel_* represents the desired PN steering correction.
# #pn_turn_scale controls how strongly that correction can
# influence the heading during a single tick.
#
# A larger #pn_turn_scale = slower turning.
# A smaller #pn_turn_scale = faster turning.
#
# This preserves forward motion instead of allowing PN to
# completely replace the missile's existing heading.
# ------------------------------------------------------------

scoreboard players operation #pn_math pn_scale = @s pn_accel_x
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_x += #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_accel_y
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_y += #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_accel_z
scoreboard players operation #pn_math pn_scale /= #pn_turn_scale pn_scale
scoreboard players operation @s pn_new_z += #pn_math pn_scale


# ------------------------------------------------------------
# FIND LARGEST ABSOLUTE COMPONENT
# ------------------------------------------------------------

scoreboard players set @s pn_new_scale 0

scoreboard players operation #pn_math pn_scale = @s pn_new_x
execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale
execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_new_y
execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale
execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale

scoreboard players operation #pn_math pn_scale = @s pn_new_z
execute if score #pn_math pn_scale matches ..-1 run scoreboard players operation #pn_math pn_scale *= #negative_one pn_scale
execute if score #pn_math pn_scale > @s pn_new_scale run scoreboard players operation @s pn_new_scale = #pn_math pn_scale


# ------------------------------------------------------------
# NORMALIZE NEW HEADING
# ------------------------------------------------------------

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_x *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_x /= @s pn_new_scale

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_y *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_y /= @s pn_new_scale

execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_z *= #pn_direction_scale pn_scale
execute if score @s pn_new_scale matches 1.. run scoreboard players operation @s pn_new_z /= @s pn_new_scale


# ============================================================
# CALCULATE MOVEMENT VECTOR
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
# MOVEMENT DEBUG
# ============================================================

# tellraw @a [{"text":"[MOVE DEBUG] ","color":"gold"},{"text":"Controller ","color":"yellow"},{"score":{"name":"@s","objective":"controller_id"}},{"text":" | DIR: "},{"score":{"name":"@s","objective":"pn_new_x"}},{"text":" / "},{"score":{"name":"@s","objective":"pn_new_y"}},{"text":" / "},{"score":{"name":"@s","objective":"pn_new_z"}},{"text":" | SPEED: "},{"score":{"name":"@s","objective":"pn_speed_scale"}},{"text":" | MOVE: "},{"score":{"name":"@s","objective":"pn_move_x"}},{"text":" / "},{"score":{"name":"@s","objective":"pn_move_y"}},{"text":" / "},{"score":{"name":"@s","objective":"pn_move_z"}}]


# ============================================================
# CONVERT MOVEMENT TO DECIMAL VALUES
# ============================================================

data modify storage missile:movement dx set value 0.0
data modify storage missile:movement dy set value 0.0
data modify storage missile:movement dz set value 0.0

execute store result storage missile:movement dx double 0.001 run scoreboard players get @s pn_move_x
execute store result storage missile:movement dy double 0.001 run scoreboard players get @s pn_move_y
execute store result storage missile:movement dz double 0.001 run scoreboard players get @s pn_move_z


# ============================================================
# APPLY CALCULATED MOVEMENT
# ============================================================

function missile:movement_apply with storage missile:movement


# ============================================================
# SAVE NEW VELOCITY
# ============================================================

scoreboard players operation @s missile_vx = @s pn_move_x
scoreboard players operation @s missile_vy = @s pn_move_y
scoreboard players operation @s missile_vz = @s pn_move_z


# ============================================================
# SAVE NEW DIRECTION
# ============================================================

scoreboard players operation @s pn_dir_x = @s pn_new_x
scoreboard players operation @s pn_dir_y = @s pn_new_y
scoreboard players operation @s pn_dir_z = @s pn_new_z


# ============================================================
# CLEAR MOVEMENT STATE
# ============================================================

scoreboard players set @s pn_move_active 0