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

# ============================================================
# CROSSHAIR TARGETING SYSTEM
# ============================================================

# Temporary designation tag
# Applied to the single enemy currently under the player's crosshair.

tag @e[type=#missile:valid_targets] remove crosshair_target

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
function missile:crosshair_targeting
function missile:guidance
# function missile:terrain
# function missile:collision