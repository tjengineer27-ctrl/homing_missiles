# ============================================================
# HOMING MISSILE - FINALIZE PRE-LAUNCH CONFIGURATION
# ============================================================

# ------------------------------------------------------------
# VERIFY BASE WARHEAD
# ------------------------------------------------------------

execute unless score #config_warhead missile_config matches 1..4 run say ERROR: NO WARHEAD SELECTED

# ------------------------------------------------------------
# VERIFY YIELD
# ------------------------------------------------------------

execute unless score #config_yield missile_config matches 1..3 run say ERROR: NO YIELD SELECTED

# ------------------------------------------------------------
# VERIFY POTION SUBTYPE
# ------------------------------------------------------------

execute if score #config_warhead missile_config matches 4 unless score #config_potion missile_config matches 1..4 run say ERROR: NO POTION SUBTYPE SELECTED

# ------------------------------------------------------------
# CALCULATE CONFIGURATION STATUS
# ------------------------------------------------------------

execute if score #config_warhead missile_config matches 1..4 if score #config_yield missile_config matches 1..3 if score #config_potion missile_config matches 1..4 run scoreboard players set #config_status missile_config 1

# ------------------------------------------------------------
# REPORT SUCCESS
# ------------------------------------------------------------

execute if score #config_status missile_config matches 1 run say MISSILE CONFIGURATION FINALIZED

# ------------------------------------------------------------
# DEBUG - SHOW SELECTED VALUES
# ------------------------------------------------------------

execute if score #config_status missile_config matches 1 run scoreboard players get #config_warhead missile_config

execute if score #config_status missile_config matches 1 run scoreboard players get #config_yield missile_config

execute if score #config_status missile_config matches 1 run scoreboard players get #config_potion missile_config