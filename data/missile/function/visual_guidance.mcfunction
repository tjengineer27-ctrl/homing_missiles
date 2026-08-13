# ============================================================
# HOMING MISSILE - VISUAL GUIDANCE
# ============================================================

# ------------------------------------------------------------
# CLEAR PREVIOUS VISUAL FACING TARGET
# ------------------------------------------------------------

tag @e[type=#missile:valid_targets,tag=visual_facing_target] remove visual_facing_target

# ------------------------------------------------------------
# RESOLVE THIS CONTROLLER'S TARGET FOR VISUAL ORIENTATION
# ------------------------------------------------------------

execute as @e[type=#missile:valid_targets] if score @s target_id = #guidance_target target_id run tag @s add visual_facing_target

# ------------------------------------------------------------
# APPLY FIREWORK MODEL ORIENTATION
# ------------------------------------------------------------

execute as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run data merge entity @s {transformation:{left_rotation:[0.0f,0.7071f,0.7071f,0.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f],scale:[1.0f,1.0f,1.0f]}}

# ------------------------------------------------------------
# DYNAMICALLY AIM FIREWORK AT TARGET
# ------------------------------------------------------------

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id run tp @s ~ ~ ~ facing entity @e[type=#missile:valid_targets,tag=visual_facing_target,limit=1] eyes

# ------------------------------------------------------------
# MISSILE TRAIL - FLAME EXHAUST
# ------------------------------------------------------------

# Immediate exhaust
execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-0.45 run particle minecraft:flame ~ ~ ~ 0.035 0.035 0.035 0.015 5 force

# Rear exhaust — maximum one block behind missile
execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-0.85 run particle minecraft:flame ~ ~ ~ 0.035 0.035 0.035 0.01 3 force

# ------------------------------------------------------------ 
# MISSILE TRAIL - THICK LINGERING SMOKE 
# ------------------------------------------------------------ 

# Dense smoke immediately behind missile 

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-0.7 run particle minecraft:campfire_signal_smoke ~ ~ ~ 0.12 0.12 0.12 0 3 force 

# Dense middle smoke 

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-1.2 run particle minecraft:campfire_signal_smoke ~ ~ ~ 0.14 0.14 0.14 0 3 force 

# Wider rear smoke 

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-1.7 run particle minecraft:campfire_signal_smoke ~ ~ ~ 0.18 0.18 0.18 0 2 force 

# Faint outer smoke 

execute at @s as @e[type=minecraft:item_display,tag=missile_visual] if score @s visual_controller_id = #active_controller controller_id at @s positioned ^ ^ ^-2.2 run particle minecraft:campfire_signal_smoke ~ ~ ~ 0.22 0.22 0.22 0 1 force