# ============================================================
# HOMING MISSILE - CROSSHAIR SCAN
# ============================================================
#
# Player context:
# @s = player
#
# Scan:
# 128 block maximum range
# 45 degree total cone
# 22.5 degrees each side
#
# No line-of-sight restriction.
#
# This first implementation samples points along the player's
# view vector. The search radius increases with distance to
# approximate the 22.5 degree cone.
# ============================================================

# ------------------------------------------------------------
# SCAN 8 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^8 if entity @e[type=#missile:valid_targets,distance=..3.3,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..3.3,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 16 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^16 if entity @e[type=#missile:valid_targets,distance=..6.6,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..6.6,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 24 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^24 if entity @e[type=#missile:valid_targets,distance=..9.9,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..9.9,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 32 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^32 if entity @e[type=#missile:valid_targets,distance=..13.3,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..13.3,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 40 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^40 if entity @e[type=#missile:valid_targets,distance=..16.6,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..16.6,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 48 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^48 if entity @e[type=#missile:valid_targets,distance=..19.9,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..19.9,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 56 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^56 if entity @e[type=#missile:valid_targets,distance=..23.2,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..23.2,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 64 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^64 if entity @e[type=#missile:valid_targets,distance=..26.5,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..26.5,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 72 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^72 if entity @e[type=#missile:valid_targets,distance=..29.8,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..29.8,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 80 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^80 if entity @e[type=#missile:valid_targets,distance=..33.1,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..33.1,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 88 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^88 if entity @e[type=#missile:valid_targets,distance=..36.4,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..36.4,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 96 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^96 if entity @e[type=#missile:valid_targets,distance=..39.8,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..39.8,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 104 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^104 if entity @e[type=#missile:valid_targets,distance=..43.1,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..43.1,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 112 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^112 if entity @e[type=#missile:valid_targets,distance=..46.4,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..46.4,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 120 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^120 if entity @e[type=#missile:valid_targets,distance=..49.7,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..49.7,limit=1,sort=nearest] add crosshair_candidate

# ------------------------------------------------------------
# SCAN 128 BLOCKS
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^128 if entity @e[type=#missile:valid_targets,distance=..53.0,limit=1,sort=nearest] run tag @e[type=#missile:valid_targets,distance=..53.0,limit=1,sort=nearest] add crosshair_candidate