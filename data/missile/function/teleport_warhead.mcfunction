# ============================================================
# HOMING MISSILE - TELEPORTATION WARHEAD
# ============================================================

# ------------------------------------------------------------
# WARHEAD ACTIVATION
# ------------------------------------------------------------

say TELEPORTATION WARHEAD ACTIVATED

# ------------------------------------------------------------
# TELEPORT AOE TARGETS
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run tp @s ~ ~50 ~

# ------------------------------------------------------------
# TELEPORTATION VISUAL
# ------------------------------------------------------------

# Main portal particle burst
particle minecraft:portal ~ ~1 ~ 0.8 0.8 0.8 0.35 80 force

# Dense reverse-portal burst
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.6 0.6 0.25 50 force

# Secondary portal burst for additional spread
particle minecraft:portal ~ ~1 ~ 0.45 0.45 0.45 0.5 40 force
