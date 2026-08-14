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
#
# @s is still the missile controller here.
# This MUST happen before dispatching into the potion subtype.
# ------------------------------------------------------------

scoreboard players operation #active_controller controller_id = @s controller_id

# ------------------------------------------------------------
# CAPTURE POTION SETTINGS
# ------------------------------------------------------------

scoreboard players operation #active_potion_type potion_type = @s potion_type

scoreboard players operation #active_warhead_yield warhead_yield = @s warhead_yield

# ------------------------------------------------------------
# DEBUG - CAPTURED POTION SETTINGS
# ------------------------------------------------------------

tellraw @a [{"text":"[POTION DEBUG] Controller: ","color":"gold"},{"score":{"name":"#active_controller","objective":"controller_id"}},{"text":" | Type: ","color":"gold"},{"score":{"name":"#active_potion_type","objective":"potion_type"}},{"text":" | Yield: ","color":"gold"},{"score":{"name":"#active_warhead_yield","objective":"warhead_yield"}}]

# ------------------------------------------------------------
# DISPATCH POTION SUBTYPE
# ------------------------------------------------------------

execute if score #config_potion #config_potion missile_config matches 1 run function missile:wither_warhead

execute if score #config_potion missile_config matches 2 run function missile:poison_warhead

execute if score #config_potion missile_config matches 3 run function missile:slowness_warhead

execute if score #config_potion missile_config matches 4 run function missile:weakness_warhead