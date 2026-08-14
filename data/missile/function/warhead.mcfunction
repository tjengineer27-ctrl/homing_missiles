# ============================================================
# HOMING MISSILE - WARHEAD DISPATCHER
# ============================================================

say WARHEAD DISPATCHER ENTERED

execute if score @s warhead_type matches 1 run say WARHEAD TYPE = EXPLOSIVE
execute if score @s warhead_type matches 2 run say WARHEAD TYPE = POTION
execute if score @s warhead_type matches 3 run say WARHEAD TYPE = FIRE
execute if score @s warhead_type matches 4 run say WARHEAD TYPE = TELEPORT

execute if score @s warhead_yield matches 1 run say WARHEAD YIELD = LOW
execute if score @s warhead_yield matches 2 run say WARHEAD YIELD = MEDIUM
execute if score @s warhead_yield matches 3 run say WARHEAD YIELD = HIGH

execute if score @s warhead_type matches 1 run function missile:explosive_warhead

execute if score @s warhead_type matches 2 run function missile:potion_warhead

execute if score @s warhead_type matches 3 run function missile:fire_warhead

execute if score @s warhead_type matches 4 run function missile:teleport_warhead