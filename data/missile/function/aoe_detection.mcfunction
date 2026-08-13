# ============================================================

# HOMING MISSILE - AOE DETECTION

# ============================================================

# ------------------------------------------------------------

# LOAD PRIMARY TARGET ID

# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

# ------------------------------------------------------------

# RESOLVE PRIMARY TARGET

# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run tag @s add aoe_origin

# ------------------------------------------------------------

# STORE PRIMARY TARGET POSITION

# ------------------------------------------------------------

# AOE calculations use x100 scale to prevent squared-distance
# overflow on distant valid targets.

execute as @e[type=#missile:valid_targets,tag=aoe_origin] run execute store result score #aoe_target_x aoe_target_x run data get entity @s Pos[0] 100
execute as @e[type=#missile:valid_targets,tag=aoe_origin] run execute store result score #aoe_target_y aoe_target_y run data get entity @s Pos[1] 100
execute as @e[type=#missile:valid_targets,tag=aoe_origin] run execute store result score #aoe_target_z aoe_target_z run data get entity @s Pos[2] 100

# ------------------------------------------------------------

# CLEAR PREVIOUS AOE TARGET MARKS

# ------------------------------------------------------------

# scoreboard players set @e[type=#missile:valid_targets] aoe_controller_id 0

# ------------------------------------------------------------

# CALCULATE ACTIVE AOE RADIUS

# ------------------------------------------------------------

scoreboard players operation #active_aoe_radius aoe_radius_squared = @s yield_radius

# AOE radius uses x100 scale.

scoreboard players set #aoe_scale aoe_radius_squared 100

# Convert blocks to x100 scale

scoreboard players operation #active_aoe_radius aoe_radius_squared *= #aoe_scale aoe_radius_squared

# Square the scaled radius

scoreboard players operation #active_aoe_radius aoe_radius_squared *= #active_aoe_radius aoe_radius_squared

# ------------------------------------------------------------

# DEBUG - CONTROLLER CONTEXT

# ------------------------------------------------------------

say AOE DETECTION CONTEXT

execute if score @s warhead_yield matches 1 run say CONTROLLER YIELD = LOW
execute if score @s warhead_yield matches 2 run say CONTROLLER YIELD = MEDIUM
execute if score @s warhead_yield matches 3 run say CONTROLLER YIELD = HIGH

execute if score @s yield_radius matches 1.. run say YIELD RADIUS EXISTS
execute unless score @s yield_radius matches 1.. run say ERROR: CONTROLLER YIELD RADIUS IS ZERO OR MISSING

# ------------------------------------------------------------

# SCAN AOE AROUND PRIMARY TARGET

# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=aoe_origin] at @s run function missile:aoe_radius_scan

# ------------------------------------------------------------
# INCLUDE PRIMARY TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=aoe_origin] run scoreboard players operation @s aoe_controller_id = #active_controller controller_id

# ------------------------------------------------------------
# DEBUG - VERIFY AOE ASSIGNMENT
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run say [AOE DEBUG] TARGET SUCCESSFULLY ASSIGNED

# ------------------------------------------------------------
# CLEAR TEMPORARY ORIGIN TAG
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=aoe_origin] remove aoe_origin