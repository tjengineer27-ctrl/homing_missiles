# ============================================================
# HOMING MISSILE - CROSSHAIR SCAN
# ============================================================

# ------------------------------------------------------------
# DEBUG
# ------------------------------------------------------------

tellraw @a {"text":"[CROSSHAIR DEBUG] SCAN ENTERED","color":"yellow"}

# ------------------------------------------------------------
# TEST FOR TARGETS ALONG CROSSHAIR
#
# 128 BLOCK MAX RANGE
#
# No line-of-sight check is performed.
# Walls do NOT block designation.
# ------------------------------------------------------------

execute anchored eyes positioned ^ ^ ^8 if entity @e[type=#missile:valid_targets,distance=..3] run say [CROSSHAIR DEBUG] TARGET IN 8 BLOCK BAND

execute anchored eyes positioned ^ ^ ^16 if entity @e[type=#missile:valid_targets,distance=..6] run say [CROSSHAIR DEBUG] TARGET IN 16 BLOCK BAND

execute anchored eyes positioned ^ ^ ^32 if entity @e[type=#missile:valid_targets,distance=..13] run say [CROSSHAIR DEBUG] TARGET IN 32 BLOCK BAND

execute anchored eyes positioned ^ ^ ^64 if entity @e[type=#missile:valid_targets,distance=..27] run say [CROSSHAIR DEBUG] TARGET IN 64 BLOCK BAND

execute anchored eyes positioned ^ ^ ^128 if entity @e[type=#missile:valid_targets,distance=..53] run say [CROSSHAIR DEBUG] TARGET IN 128 BLOCK BAND