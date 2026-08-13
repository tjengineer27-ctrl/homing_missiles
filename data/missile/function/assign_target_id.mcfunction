# ============================================================
# ASSIGN UNIQUE TARGET ID
# ============================================================

scoreboard players add #next_target_id target_id 1
scoreboard players operation @s target_id = #next_target_id target_id
tag @s add target_id_assigned