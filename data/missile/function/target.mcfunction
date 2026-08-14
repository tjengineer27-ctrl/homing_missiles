# ============================================================
# HOMING MISSILE - INITIAL TARGET ACQUISITION
# ============================================================

# ============================================================
# FIND VALID TARGET
# ============================================================

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=needs_target] at @s if entity @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] run tag @s add has_target


# ============================================================
# CREATE MISSILE CONTROLLER
# ============================================================

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=has_target,tag=!controller_created] at @s run summon minecraft:marker ~ ~ ~ {Tags:["missile_controller"]}

# Mark the firework so a controller is not created again
execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=has_target,tag=!controller_created] run tag @s add controller_created


# ============================================================
# ASSIGN UNIQUE CONTROLLER ID
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!controller_id_assigned] run scoreboard players add #next_controller_id controller_id 1

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!controller_id_assigned] run scoreboard players operation @s controller_id = #next_controller_id controller_id

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!controller_id_assigned] run tag @s add controller_id_assigned


# ============================================================
# SNAPSHOT PRE-LAUNCH CONFIGURATION
# ============================================================
#
# IMPORTANT:
# These are copied from the global pre-launch configuration.
#
# #config_warhead / missile_config
# #config_yield   / missile_config
# #config_potion  / missile_config
#
# Once copied, these values belong exclusively to this
# missile controller and will NOT change during flight.
# ============================================================

# ------------------------------------------------------------
# COPY WARHEAD TYPE
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!warhead_type_assigned] run scoreboard players operation @s warhead_type = #config_warhead missile_config

# ------------------------------------------------------------
# COPY WARHEAD YIELD
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!yield_initialized] run scoreboard players operation @s warhead_yield = #config_yield missile_config

# ------------------------------------------------------------
# COPY POTION SUBTYPE
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!potion_subtype_assigned] run scoreboard players operation @s potion_type = #config_potion missile_config


# ============================================================
# MARK CONFIGURATION SNAPSHOT COMPLETE
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!warhead_type_assigned] run tag @s add warhead_type_assigned

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!yield_initialized] run tag @s add yield_initialized

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=!potion_subtype_assigned] run tag @s add potion_subtype_assigned

# ------------------------------------------------------------
# CALCULATE CONTROLLER YIELD VALUES
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_controller,tag=controller_id_assigned,tag=yield_initialized,tag=!yield_calculated] run function missile:calculate_yield


# ============================================================
# COPY CONTROLLER ID TO FIREWORK
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!firework_id_assigned] at @s run scoreboard players operation @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1,sort=nearest] missile_controller_id = @s controller_id


# ============================================================
# MARK FIREWORK ID ASSIGNED
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!firework_id_assigned] at @s if entity @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1,sort=nearest] run tag @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1,sort=nearest] add missile_controller_id_assigned

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!firework_id_assigned] run tag @s add firework_id_assigned


# ============================================================
# ATTACH FIREWORK TO CONTROLLER
# ============================================================

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_controller,tag=!firework_attached] at @s if entity @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1] run ride @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1] mount @s


# ============================================================
# MARK CONTROLLER AS HAVING FIREWORK
# ============================================================

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_controller,tag=!firework_attached] at @s if entity @e[type=minecraft:firework_rocket,tag=homing_missile,distance=..1,limit=1] run tag @s add firework_attached


# ============================================================
# CREATE AND MANAGE TRACKER
# ============================================================

# ------------------------------------------------------------
# CREATE TRACKER
# ------------------------------------------------------------

# Disabled for now
# execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=has_target,tag=!tracker_created] at @s run summon minecraft:marker ~ ~ ~ {Tags:["missile_tracker"]}


# ------------------------------------------------------------
# ATTACH TRACKER TO CONTROLLER
# ------------------------------------------------------------

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_tracker,tag=!tracker_attached] at @s run ride @s mount @e[type=minecraft:marker,tag=missile_controller,distance=..1,limit=1,sort=nearest]


# ------------------------------------------------------------
# MARK TRACKER ATTACHED
# ------------------------------------------------------------

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_tracker,tag=!tracker_attached] run tag @s add tracker_attached


# ------------------------------------------------------------
# COPY CONTROLLER ID TO TRACKER
# ------------------------------------------------------------

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_attached,tag=!tracker_controller_id_assigned] at @s run scoreboard players operation @s tracker_controller_id = @e[type=minecraft:marker,tag=missile_controller,distance=..1,limit=1,sort=nearest] controller_id


# ------------------------------------------------------------
# MARK TRACKER CONTROLLER ID ASSIGNED
# ------------------------------------------------------------

# Disabled for now
# execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_attached,tag=!tracker_controller_id_assigned] at @s if score @s tracker_controller_id matches 1.. run tag @s add tracker_controller_id_assigned


# ------------------------------------------------------------
# COPY SELECTED TARGET ID TO TRACKER
# ------------------------------------------------------------

execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=has_target,tag=!tracker_created] at @s run scoreboard players operation @e[type=minecraft:marker,tag=missile_tracker,distance=..1,sort=nearest,limit=1] tracker_target = @e[type=#missile:valid_targets,distance=..128,sort=nearest,limit=1] target_id


# ------------------------------------------------------------
# MARK TRACKER AS HAVING A TARGET
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=!tracker_has_target] at @s run tag @s add tracker_has_target


# ------------------------------------------------------------
# RESOLVE TRACKER TARGET
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] run scoreboard players operation #resolution_target target_id = @s tracker_target

execute as @e[type=minecraft:marker,tag=missile_tracker,tag=tracker_has_target] run execute as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run tag @s add target_resolved


# ============================================================
# MARK TRACKER CREATED
# ============================================================

# Disabled for now
# execute as @e[type=minecraft:firework_rocket,tag=homing_missile,tag=has_target,tag=!tracker_created] run tag @s add tracker_created