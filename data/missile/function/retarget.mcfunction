# ============================================================
# HOMING MISSILE - RETARGET LOST MISSILE
# ============================================================

# ------------------------------------------------------------
# FIND NEAREST VALID REPLACEMENT TARGET
# ------------------------------------------------------------

execute if entity @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] run scoreboard players operation @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] tracker_target = @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] target_id

# ------------------------------------------------------------
# RESTORE TRACKER TARGET STATE
# ------------------------------------------------------------

execute if entity @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] run tag @e[type=minecraft:marker,tag=missile_tracker,distance=..1,limit=1,sort=nearest] add tracker_has_target

# ------------------------------------------------------------
# NO REPLACEMENT TARGET
# ------------------------------------------------------------

execute unless entity @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] run tag @s add target_lost