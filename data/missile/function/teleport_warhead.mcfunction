# ============================================================
# HOMING MISSILE - TELEPORTATION WARHEAD
# ============================================================

# say TELEPORTATION WARHEAD ACTIVATED

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S PRIMARY TARGET ID
# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

# ------------------------------------------------------------
# TELEPORT AOE TARGETS
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run tp @s ~ ~50 ~

# ------------------------------------------------------------
# LOW YIELD EFFECTS
# ------------------------------------------------------------

# Main portal particle burst
execute if score @s warhead_yield matches 1 run particle minecraft:portal ~ ~1 ~ 0.8 0.8 0.8 0.35 80 force

# Dense reverse-portal burst
execute if score @s warhead_yield matches 1 run particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.6 0.6 0.25 50 force

# Secondary portal burst
execute if score @s warhead_yield matches 1 run particle minecraft:portal ~ ~1 ~ 0.45 0.45 0.45 0.5 40 force

# ------------------------------------------------------------
# MEDIUM YIELD EFFECTS
# ------------------------------------------------------------

execute if score @s warhead_yield matches 2 run particle minecraft:portal ~ ~1 ~ 1.0 1.0 1.0 0.35 120 force

execute if score @s warhead_yield matches 2 run particle minecraft:reverse_portal ~ ~1 ~ 0.75 0.75 0.75 0.25 75 force

execute if score @s warhead_yield matches 2 run particle minecraft:portal ~ ~1 ~ 0.55 0.55 0.55 0.5 60 force

# ------------------------------------------------------------
# HIGH YIELD EFFECTS
# ------------------------------------------------------------

execute if score @s warhead_yield matches 3 run particle minecraft:portal ~ ~1 ~ 1.2 1.2 1.2 0.35 180 force

execute if score @s warhead_yield matches 3 run particle minecraft:reverse_portal ~ ~1 ~ 0.9 0.9 0.9 0.25 110 force

execute if score @s warhead_yield matches 3 run particle minecraft:portal ~ ~1 ~ 0.7 0.7 0.7 0.5 90 force