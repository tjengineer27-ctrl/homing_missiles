# ============================================================
# HOMING MISSILE - POTION / STATUS EFFECT WARHEAD
# ============================================================

say POTION WARHEAD ACTIVATED

# ------------------------------------------------------------
# APPLY WITHER II
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run effect give @s minecraft:wither 5 1 true

# ------------------------------------------------------------
# SMALL IMPACT BURST
# ------------------------------------------------------------

particle minecraft:explosion ~ ~ ~ 0.2 0.2 0.2 0.05 8 force

# ------------------------------------------------------------
# BLACK POTION EFFECT BURST
# ------------------------------------------------------------

particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.65 0.65 0.65 0.12 80 force

# ------------------------------------------------------------
# DENSE INNER BLACK SWIRL
# ------------------------------------------------------------

particle minecraft:entity_effect{color:[0.0,0.0,0.0,1.0]} ~ ~1 ~ 0.3 0.3 0.3 0.2 35 force

