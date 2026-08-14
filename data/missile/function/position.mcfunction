# ============================================================
# HOMING MISSILE - TARGET POSITION UPDATE
# ============================================================

# ------------------------------------------------------------
# CLEAR PREVIOUS POSITION STATE
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] run data remove entity @s TargetPosition

# ------------------------------------------------------------
# COPY ASSIGNED TARGET POSITION TO TRACKER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] at @s run data modify entity @s TargetPosition set from entity @e[type=#missile:valid_targets,distance=..128,limit=1] Pos