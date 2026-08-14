# ============================================================
# HOMING MISSILE - FIRE WARHEAD
# ============================================================

say FIRE WARHEAD ACTIVATED

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S PRIMARY TARGET ID
# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

scoreboard players operation #active_warhead_yield warhead_yield = @s warhead_yield

# ------------------------------------------------------------
# KNOCKBACK - STORE EXPLOSION POSITION
# ------------------------------------------------------------

execute store result score #controller_x guidance_cx run data get entity @s Pos[0] 1000
execute store result score #controller_y guidance_cy run data get entity @s Pos[1] 1000
execute store result score #controller_z guidance_cz run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# LOAD KNOCKBACK SETTINGS FROM CONTROLLER
# ------------------------------------------------------------

scoreboard players operation #active_yield_knockback knockback_scale = @s yield_knockback

# LOW    = x1.00
# MEDIUM = x1.75
# HIGH   = x2.50

scoreboard players set #knockback_multiplier knockback_scale 1000

execute if score @s warhead_yield matches 2 run scoreboard players set #knockback_multiplier knockback_scale 1750
execute if score @s warhead_yield matches 3 run scoreboard players set #knockback_multiplier knockback_scale 2500

# ------------------------------------------------------------
# CALCULATE FINAL YIELD-BASED KNOCKBACK STRENGTH
# ------------------------------------------------------------

scoreboard players operation #active_yield_knockback knockback_scale *= #knockback_multiplier knockback_scale
scoreboard players operation #active_yield_knockback knockback_scale /= #scale_1000 knockback_scale

# ------------------------------------------------------------
# KNOCKBACK TARGETS
#
# Process knockback BEFORE ignition so the target receives
# the launch before any subsequent fire processing.
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run function missile:knockback_target

# ------------------------------------------------------------
# IGNITE AOE TARGETS
# ------------------------------------------------------------

# LOW = 40 seconds
# MEDIUM = 80 seconds
# HIGH = 160 seconds

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run data merge entity @s {Fire:800s}

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run data merge entity @s {Fire:1600s}

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run data merge entity @s {Fire:3200s}

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run data get entity @s Fire

# ------------------------------------------------------------
# LOW YIELD EFFECTS
# ------------------------------------------------------------

# Main flame burst
execute if score @s warhead_yield matches 1 run particle minecraft:flame ~ ~1 ~ 0.45 0.45 0.45 0.15 50 force

# Gravity-affected lava sparks
execute if score @s warhead_yield matches 1 run particle minecraft:lava ~ ~1 ~ 0.6 0.6 0.6 0.7 40 force

# Brief smoke
execute if score @s warhead_yield matches 1 run particle minecraft:large_smoke ~ ~1 ~ 0.35 0.35 0.35 0.08 15 force

# ------------------------------------------------------------
# MEDIUM YIELD EFFECTS
# ------------------------------------------------------------

execute if score @s warhead_yield matches 2 run particle minecraft:flame ~ ~1 ~ 0.65 0.65 0.65 0.15 85 force

execute if score @s warhead_yield matches 2 run particle minecraft:lava ~ ~1 ~ 0.8 0.8 0.8 0.7 65 force

execute if score @s warhead_yield matches 2 run particle minecraft:large_smoke ~ ~1 ~ 0.45 0.45 0.45 0.08 30 force

# ------------------------------------------------------------
# HIGH YIELD EFFECTS
# ------------------------------------------------------------

execute if score @s warhead_yield matches 3 run particle minecraft:flame ~ ~1 ~ 0.9 0.9 0.9 0.15 130 force

execute if score @s warhead_yield matches 3 run particle minecraft:lava ~ ~1 ~ 1.0 1.0 1.0 0.7 100 force

execute if score @s warhead_yield matches 3 run particle minecraft:large_smoke ~ ~1 ~ 0.6 0.6 0.6 0.08 50 force