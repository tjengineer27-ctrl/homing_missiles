# ============================================================

# HOMING MISSILE - AOE DETECTION CHECK

# ============================================================

# ------------------------------------------------------------

# STORE THIS TARGET'S POSITION AT x100 SCALE

# ------------------------------------------------------------

execute store result score @s aoe_dx run data get entity @s Pos[0] 100
execute store result score @s aoe_dy run data get entity @s Pos[1] 100
execute store result score @s aoe_dz run data get entity @s Pos[2] 100

tellraw @a [{"text":"[AOE DEBUG] Controller source ID = "},{"score":{"name":"#active_controller","objective":"controller_id"}}]

# ------------------------------------------------------------

# CONVERT TO DISTANCE FROM PRIMARY TARGET

# ------------------------------------------------------------

scoreboard players operation @s aoe_dx -= #aoe_target_x aoe_target_x
scoreboard players operation @s aoe_dy -= #aoe_target_y aoe_target_y
scoreboard players operation @s aoe_dz -= #aoe_target_z aoe_target_z

# ------------------------------------------------------------

# X²

# ------------------------------------------------------------

scoreboard players operation @s aoe_distance = @s aoe_dx
scoreboard players operation @s aoe_distance *= @s aoe_dx

# ------------------------------------------------------------

# Y²

# ------------------------------------------------------------

scoreboard players operation #aoe_math aoe_math = @s aoe_dy
scoreboard players operation #aoe_math aoe_math *= #aoe_math aoe_math
scoreboard players operation @s aoe_distance += #aoe_math aoe_math

# ------------------------------------------------------------

# Z²

# ------------------------------------------------------------

scoreboard players operation #aoe_math aoe_math = @s aoe_dz
scoreboard players operation #aoe_math aoe_math *= #aoe_math aoe_math
scoreboard players operation @s aoe_distance += #aoe_math aoe_math

# ------------------------------------------------------------
# AOE ASSIGNMENT TEST
# ------------------------------------------------------------

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run say [AOE DEBUG] TARGET IS INSIDE RADIUS

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run scoreboard players set @s aoe_controller_id 999

execute if score @s aoe_controller_id matches 999 run say [AOE DEBUG] TARGET RECEIVED 999

# ------------------------------------------------------------
# DEBUG - AOE CONTROLLER ID TRANSFER
# ------------------------------------------------------------

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run say [AOE DEBUG] TARGET IS INSIDE RADIUS

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run scoreboard players operation #debug_controller_id debug_damage = #active_controller controller_id

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run scoreboard players operation @s aoe_controller_id = #active_controller controller_id

execute if score @s aoe_distance <= #active_aoe_radius aoe_radius_squared run say [AOE DEBUG] ASSIGNMENT ATTEMPTED

execute if score @s aoe_controller_id matches 1.. run say [AOE DEBUG] TARGET RECEIVED CONTROLLER ID