# ============================================================
# HOMING MISSILE - WEAKNESS POTION WARHEAD
# ============================================================

say WEAKNESS WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY YIELD-SCALED WEAKNESS II
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run effect give @s minecraft:weakness 20 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run effect give @s minecraft:weakness 40 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run effect give @s minecraft:weakness 80 1 true

# ------------------------------------------------------------
# GRAY WEAKNESS PARTICLES
# ------------------------------------------------------------

execute if score #active_warhead_yield warhead_yield matches 1 run particle minecraft:entity_effect{color:[0.5,0.5,0.5,1.0]} ~ ~1 ~ 0.65 0.65 0.65 0.12 80 force

execute if score #active_warhead_yield warhead_yield matches 2 run particle minecraft:entity_effect{color:[0.5,0.5,0.5,1.0]} ~ ~1 ~ 0.8 0.8 0.8 0.12 120 force

execute if score #active_warhead_yield warhead_yield matches 3 run particle minecraft:entity_effect{color:[0.5,0.5,0.5,1.0]} ~ ~1 ~ 1.0 1.0 1.0 0.12 180 force