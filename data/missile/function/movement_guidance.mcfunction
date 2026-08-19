# ============================================================
# HOMING MISSILE - GUIDANCE MOVEMENT DEBUG
# ============================================================

tellraw @a [{"text":"[MOVEMENT ENTRY] ","color":"aqua"},{"text":"Controller ","color":"yellow"},{"score":{"name":"@s","objective":"controller_id"}}]

function missile:movement_guidance_active