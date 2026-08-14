# ============================================================
# HOMING MISSILE - SLOWNESS POTION WARHEAD
# ============================================================

say SLOWNESS WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY YIELD-SCALED SLOWNESS II
# ------------------------------------------------------------

# LOW    = 20 seconds
# MEDIUM = 40 seconds
# HIGH   = 80 seconds
#
# Amplifier:
# 1 = Slowness II

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run effect give @s minecraft:slowness 20 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run effect give @s minecraft:slowness 40 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run effect give @s minecraft:slowness 80 1 true