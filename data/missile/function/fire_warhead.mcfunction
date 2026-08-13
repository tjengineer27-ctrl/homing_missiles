# ============================================================
# HOMING MISSILE - FIRE WARHEAD
# ============================================================

# ------------------------------------------------------------
# IGNITE AOE TARGETS
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run data modify entity @s Fire set value 100s

# ------------------------------------------------------------
# FIRE DETONATION VISUAL
# ------------------------------------------------------------

# Main flame burst
particle minecraft:flame ~ ~1 ~ 0.45 0.45 0.45 0.15 50 force

# Gravity-affected lava sparks
particle minecraft:lava ~ ~1 ~ 0.6 0.6 0.6 0.7 40 force

# Brief smoke accompanying the fire burst
particle minecraft:large_smoke ~ ~1 ~ 0.35 0.35 0.35 0.08 15 force