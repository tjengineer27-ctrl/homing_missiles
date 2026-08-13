# ============================================================
# HOMING MISSILE - GUIDANCE
# ============================================================

# ------------------------------------------------------------
# CLEAR PREVIOUS GUIDANCE STATE
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=guidance_target] remove guidance_target

# ------------------------------------------------------------
# PROCESS EACH CONTROLLER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller] at @s run function missile:guidance_controller