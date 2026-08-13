# ============================================================
# HOMING MISSILE - AOE RADIUS SCAN
# ============================================================

# ------------------------------------------------------------
# SCAN ALL VALID TARGETS
# ------------------------------------------------------------

# The active AOE radius has already been calculated by
# aoe_detection.mcfunction while the execution context was
# still the missile controller.

execute as @e[type=#missile:valid_targets,tag=!aoe_origin] run function missile:aoe_detection_check
