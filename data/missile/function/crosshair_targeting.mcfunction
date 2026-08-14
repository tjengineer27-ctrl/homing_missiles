# ============================================================
# HOMING MISSILE - CROSSHAIR TARGET DESIGNATION
# ============================================================

# ------------------------------------------------------------
# CLEAR PREVIOUS DESIGNATION
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=crosshair_target] remove crosshair_target

# ------------------------------------------------------------
# CLEAR PREVIOUS TARGET ID
# ------------------------------------------------------------

scoreboard players set #crosshair_target_id crosshair_target_id 0

# ------------------------------------------------------------
# PROCESS PLAYERS HOLDING A LOADED FIREWORK CROSSBOW
# ------------------------------------------------------------

execute as @a if items entity @s weapon.mainhand minecraft:crossbow[charged_projectiles=[{id:"minecraft:firework_rocket"}]] run function missile:crosshair_scan

# ------------------------------------------------------------
# APPLY RED GLOW
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=crosshair_target] run effect give @s minecraft:glowing 2 0 true