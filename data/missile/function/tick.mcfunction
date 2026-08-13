# ============================================================
# HOMING MISSILE - MAIN TICK
# ============================================================

# ------------------------------------------------------------
# INITIALIZATION
# ------------------------------------------------------------

execute as @e[type=minecraft:firework_rocket,tag=!homing_missile] at @s run function missile:init

# ------------------------------------------------------------
# AGE
# ------------------------------------------------------------

execute as @e[type=minecraft:firework_rocket,tag=homing_missile] run function missile:age

# ------------------------------------------------------------
# TARGET ID ASSIGNMENT
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets,tag=!target_id_assigned] run function missile:assign_target_id

# ------------------------------------------------------------
# TARGET ACQUISITION
# ------------------------------------------------------------

function missile:target

# ------------------------------------------------------------
# TRACKER
# ------------------------------------------------------------

function missile:tracker

# ------------------------------------------------------------
# TRACK ASSIGNED TARGET
# ------------------------------------------------------------

function missile:track_target

# ------------------------------------------------------------
# TARGET POSITION UPDATE
# ------------------------------------------------------------

# function missile:position

function missile:visual

# ------------------------------------------------------------
# BASIC MOVEMENT
# ------------------------------------------------------------

function missile:movement

# ------------------------------------------------------------
# FUTURE SYSTEMS
# ------------------------------------------------------------

# function missile:retarget
function missile:guidance
# function missile:terrain
# function missile:collision