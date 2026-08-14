# ============================================================
# HOMING MISSILE - POTION / STATUS EFFECT WARHEAD
# ============================================================

say POTION WARHEAD ACTIVATED

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S PRIMARY TARGET ID
# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

# ------------------------------------------------------------
# CAPTURE CONTROLLER ID
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# ------------------------------------------------------------
# GET WARHEAD YIELD
# ------------------------------------------------------------

scoreboard players operation #active_warhead_yield warhead_yield = @s warhead_yield

# ------------------------------------------------------------
# DISPATCH POTION SUBTYPE
# ------------------------------------------------------------

execute if score @s potion_type matches 1 run function missile:wither_warhead

execute if score @s potion_type matches 2 run function missile:poison_warhead

execute if score @s potion_type matches 3 run function missile:slowness_warhead

execute if score @s potion_type matches 4 run function missile:weakness_warhead