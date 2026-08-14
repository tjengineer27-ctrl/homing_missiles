# ============================================================
# HOMING MISSILE - SLOWNESS POTION WARHEAD
# ============================================================

say SLOWNESS WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY YIELD-SCALED SLOWNESS II
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run effect give @s minecraft:slowness 20 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run effect give @s minecraft:slowness 40 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run effect give @s minecraft:slowness 80 1 true

# ------------------------------------------------------------
# BLUE SLOWNESS PARTICLES
# ------------------------------------------------------------

execute if score #active_warhead_yield warhead_yield matches 1 run particle minecraft:entity_effect{color:[0.0,0.3,1.0,1.0]} ~ ~1 ~ 0.65 0.65 0.65 0.12 80 force

execute if score #active_warhead_yield warhead_yield matches 2 run particle minecraft:entity_effect{color:[0.0,0.3,1.0,1.0]} ~ ~1 ~ 0.8 0.8 0.8 0.12 120 force

execute if score #active_warhead_yield warhead_yield matches 3 run particle minecraft:entity_effect{color:[0.0,0.3,1.0,1.0]} ~ ~1 ~ 1.0 1.0 1.0 0.12 180 force