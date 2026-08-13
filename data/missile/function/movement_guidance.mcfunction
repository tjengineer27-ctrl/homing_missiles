# ============================================================
# HOMING MISSILE - GUIDANCE MOVEMENT
# ============================================================

# ------------------------------------------------------------
# TURN TOWARD RESOLVED TARGET
# ------------------------------------------------------------

execute unless entity @s[tag=guidance_at_target] if entity @e[type=#missile:valid_targets,tag=guidance_move_target,limit=1] facing entity @e[type=#missile:valid_targets,tag=guidance_move_target,limit=1] eyes run tp @s ~ ~ ~

# ------------------------------------------------------------
# MOVE FORWARD
# ------------------------------------------------------------

execute unless entity @s[tag=guidance_at_target] if entity @e[type=#missile:valid_targets,tag=guidance_move_target,limit=1] facing entity @e[type=#missile:valid_targets,tag=guidance_move_target,limit=1] eyes run tp @s ^ ^ ^0.25