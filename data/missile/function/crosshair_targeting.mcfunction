# ============================================================
# HOMING MISSILE - CROSSHAIR TARGETING
# ============================================================

# ------------------------------------------------------------
# CLEAR TEMPORARY CANDIDATES
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=crosshair_candidate] remove crosshair_candidate

# ------------------------------------------------------------
# SCAN PLAYER'S VIEW
# ------------------------------------------------------------

execute anchored eyes run function missile:crosshair_scan

# ------------------------------------------------------------
# CURRENT TARGET STILL VALID?
# ------------------------------------------------------------

execute if entity @e[type=#missile:valid_targets,tag=crosshair_target,tag=crosshair_candidate] run tag @e[type=#missile:valid_targets,tag=crosshair_target,tag=crosshair_candidate] add crosshair_keep

# ------------------------------------------------------------
# TARGET CHANGED / LOST
# ------------------------------------------------------------

execute unless entity @e[type=#missile:valid_targets,tag=crosshair_keep] run tag @e[type=#missile:valid_targets,tag=crosshair_target] remove crosshair_target

# ------------------------------------------------------------
# CLEAR KEEP
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=crosshair_keep] remove crosshair_keep

# ------------------------------------------------------------
# SELECT NEW TARGET
# ------------------------------------------------------------

execute unless entity @e[type=#missile:valid_targets,tag=crosshair_target] run execute as @e[type=#missile:valid_targets,tag=crosshair_candidate,limit=1,sort=nearest] run tag @s add crosshair_target

# ------------------------------------------------------------
# DEBUG NEW TARGET
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=crosshair_target,tag=!crosshair_reported] run tellraw @a [{"text":"[CROSSHAIR] SELECTED: ","color":"red"},{"selector":"@s"}]

# ------------------------------------------------------------
# MARK TARGET AS ALREADY REPORTED
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=crosshair_target] add crosshair_reported

# ------------------------------------------------------------
# RESET REPORT FLAG ON NON-TARGETS
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=!crosshair_target,tag=crosshair_reported] remove crosshair_reported

# ------------------------------------------------------------
# RED GLOW - JOIN DESIGNATED TARGET TO RED TEAM
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=crosshair_target] run team join missile_red_target @s

# ------------------------------------------------------------
# RED GLOW - APPLY GLOWING EFFECT
# ------------------------------------------------------------

effect give @e[type=#missile:valid_targets,tag=crosshair_target] minecraft:glowing 2 0 true

# ------------------------------------------------------------
# RED GLOW - REMOVE OLD TARGET FROM RED TEAM
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=!crosshair_target,team=missile_red_target] run team leave @s