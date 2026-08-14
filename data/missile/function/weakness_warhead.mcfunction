# ============================================================
# HOMING MISSILE - WEAKNESS POTION WARHEAD
# ============================================================

say WEAKNESS WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY YIELD-SCALED WEAKNESS II
# ------------------------------------------------------------

# LOW    = 20 seconds
# MEDIUM = 40 seconds
# HIGH   = 80 seconds
#
# Amplifier:
# 1 = Weakness II

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run effect give @s minecraft:weakness 20 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run effect give @s minecraft:weakness 40 1 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run effect give @s minecraft:weakness 80 1 true