# ============================================================
# HOMING MISSILE - VISUAL GUIDANCE
# ============================================================

# ------------------------------------------------------------
# APPLY FIREWORK MODEL ORIENTATION
# ------------------------------------------------------------
#
# The firework model intentionally remains upright.
#
# No target-facing or velocity-facing rotation is applied.
#
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run data merge entity @s {transformation:{left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],scale:[1.0f,1.0f,1.0f]}}


# ------------------------------------------------------------
# MISSILE TRAIL - FLAME EXHAUST
# ------------------------------------------------------------
#
# The display moves every tick, so particles spawned at its
# current position naturally form the trail behind the missile.
#
# The spread remains small and consistent so the trail does not
# expand as it gets farther from the missile.
#
# ------------------------------------------------------------

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run particle minecraft:flame ~ ~ ~ 0.035 0.035 0.035 0.015 5 force


# ------------------------------------------------------------
# MISSILE TRAIL - CONSISTENT SMOKE
# ------------------------------------------------------------
#
# Every smoke burst uses the same spread.
#
# This keeps the trail approximately the same thickness
# throughout its length instead of producing a widening cone.
#
# ------------------------------------------------------------

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run particle minecraft:campfire_signal_smoke ~ ~ ~ 0.12 0.12 0.12 0 3 force