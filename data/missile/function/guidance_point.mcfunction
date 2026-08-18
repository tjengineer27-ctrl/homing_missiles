# ============================================================
# HOMING MISSILE - CREATE PN GUIDANCE POINT
# ============================================================

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!guidance_point_created] at @s run summon minecraft:marker ~ ~ ~ {Tags:["missile_guidance_point"]}

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!guidance_point_created] at @s run scoreboard players operation @e[type=minecraft:marker,tag=missile_guidance_point,distance=..1,limit=1,sort=nearest] guidance_point_controller_id = @s controller_id

execute as @e[type=minecraft:marker,tag=missile_controller,tag=!guidance_point_created] at @s if entity @e[type=minecraft:marker,tag=missile_guidance_point,distance=..1,limit=1,sort=nearest] run tag @s add guidance_point_created