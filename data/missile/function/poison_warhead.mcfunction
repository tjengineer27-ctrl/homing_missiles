# ============================================================
# HOMING MISSILE - POISON POTION WARHEAD
# ============================================================

say POISON WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY YIELD-SCALED POISON III
# ------------------------------------------------------------

# LOW    = 20 seconds
# MEDIUM = 40 seconds
# HIGH   = 80 seconds
#
# Amplifier:
# 2 = Poison III

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 1 run effect give @s minecraft:poison 20 2 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 2 run effect give @s minecraft:poison 40 2 true

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id if score #active_warhead_yield warhead_yield matches 3 run effect give @s minecraft:poison 80 2 true