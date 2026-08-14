# ============================================================
# HOMING MISSILE - POTION / STATUS EFFECT WARHEAD
# ============================================================

say POTION WARHEAD ACTIVATED

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S PRIMARY TARGET ID
# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

# ------------------------------------------------------------
# CAPTURE CONTROLLER ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# ------------------------------------------------------------
# DISPATCH POTION SUBTYPE
# ------------------------------------------------------------

execute if score @s potion_type matches 1 run function missile:wither_warhead

execute if score @s potion_type matches 2 run function missile:poison_warhead

execute if score @s potion_type matches 3 run function missile:slowness_warhead

execute if score @s potion_type matches 4 run function missile:weakness_warhead

# ------------------------------------------------------------
# LOW YIELD EFFECTS
# ------------------------------------------------------------

execute if score #active_warhead_yield warhead_yield matches 1 run particle minecraft:explosion ~ ~ ~ 0.2 0.2 0.2 0.05 8 force

execute if score #active_warhead_yield warhead_yield matches 1 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.65 0.65 0.65 0.12 80 force

execute if score #active_warhead_yield warhead_yield matches 1 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.3 0.3 0.3 0.2 35 force

# ------------------------------------------------------------
# MEDIUM YIELD EFFECTS
# ------------------------------------------------------------

execute if score #active_warhead_yield warhead_yield matches 2 run particle minecraft:explosion ~ ~ ~ 0.3 0.3 0.3 0.05 16 force

execute if score #active_warhead_yield warhead_yield matches 2 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.8 0.8 0.8 0.12 120 force

execute if score #active_warhead_yield warhead_yield matches 2 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.4 0.4 0.4 0.2 55 force

# ------------------------------------------------------------
# HIGH YIELD EFFECTS
# ------------------------------------------------------------

execute if score #active_warhead_yield warhead_yield matches 3 run particle minecraft:explosion ~ ~ ~ 0.4 0.4 0.4 0.05 24 force

execute if score #active_warhead_yield warhead_yield matches 3 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 1.0 1.0 1.0 0.12 180 force

execute if score #active_warhead_yield warhead_yield matches 3 run particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.5 0.5 0.5 0.2 80 force