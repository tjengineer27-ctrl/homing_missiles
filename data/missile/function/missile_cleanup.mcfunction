# ============================================================
# HOMING MISSILE - CLEANUP
# ============================================================

# ------------------------------------------------------------
# REMOVE THIS MISSILE'S TRACKER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_tracker] if score @s tracker_controller_id = #active_controller controller_id run kill @s

# ------------------------------------------------------------
# REMOVE THIS MISSILE'S ORIENTATION MARKER
# ------------------------------------------------------------

execute as @e[type=minecraft:marker,tag=missile_orientation] if score @s orientation_controller_id = #active_controller controller_id run kill @s

# ------------------------------------------------------------
# REMOVE THIS MISSILE'S VISUAL FIREWORK
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run kill @s

# ------------------------------------------------------------
# REMOVE THIS MISSILE'S CONTROLLER
# ------------------------------------------------------------

kill @s