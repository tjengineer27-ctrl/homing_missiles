# ============================================================
# HOMING MISSILE - TRACK ASSIGNED TARGET
# ============================================================

# ------------------------------------------------------------
# LOAD TRACKER TARGET ID
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] run scoreboard players operation #resolution_target target_id = @s tracker_target

# ------------------------------------------------------------
# MARK THE ENTITY MATCHING THIS TRACKER'S TARGET ID
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] run execute as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run tag @s add target_tracked