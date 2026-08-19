# ============================================================
# HOMING MISSILE - INITIALIZE PN STATE
# ============================================================
#
# @s = missile_controller
#
# This runs ONCE.
#
# The firework's initial Motion becomes the controller's
# initial velocity.
#
# After this point, the controller owns the missile velocity.
#
# ============================================================


# ============================================================
# CAPTURE FIREWORK INITIAL VELOCITY
# ============================================================

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=missile_controller_id_assigned,distance=..1,limit=1,sort=nearest] store result score #initial_vx missile_vx run data get entity @s Motion[0] 1000

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=missile_controller_id_assigned,distance=..1,limit=1,sort=nearest] store result score #initial_vy missile_vy run data get entity @s Motion[1] 1000

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=missile_controller_id_assigned,distance=..1,limit=1,sort=nearest] store result score #initial_vz missile_vz run data get entity @s Motion[2] 1000


# ============================================================
# COPY INITIAL VELOCITY TO CONTROLLER
# ============================================================

scoreboard players operation @s missile_vx = #initial_vx missile_vx
scoreboard players operation @s missile_vy = #initial_vy missile_vy
scoreboard players operation @s missile_vz = #initial_vz missile_vz


# ============================================================
# CALCULATE INITIAL SPEED SCALE
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
# CREATE INITIAL NORMALIZED DIRECTION
# ============================================================

scoreboard players set @s pn_dir_x 0
scoreboard players set @s pn_dir_y 0
scoreboard players set @s pn_dir_z 0

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
# MARK PN INITIALIZATION COMPLETE
# ============================================================

tag @s add pn_initialized