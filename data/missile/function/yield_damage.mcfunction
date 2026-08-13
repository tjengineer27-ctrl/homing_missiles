# ============================================================
# HOMING MISSILE - SHARED PRIMARY TARGET DAMAGE
# ============================================================

say YIELD DAMAGE FUNCTION ENTERED

scoreboard players operation #debug_primary_damage debug_damage = @s yield_primary_damage

# ------------------------------------------------------------
# LOW YIELD
# ------------------------------------------------------------

execute if score @s yield_primary_damage matches 10 run say PRIMARY DAMAGE = 10

execute if score @s yield_primary_damage matches 10 as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run damage @s 10 minecraft:generic

# ------------------------------------------------------------
# MEDIUM YIELD
# ------------------------------------------------------------

execute if score @s yield_primary_damage matches 20 run say PRIMARY DAMAGE = 20

execute if score @s yield_primary_damage matches 20 as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run damage @s 20 minecraft:generic

# ------------------------------------------------------------
# HIGH YIELD
# ------------------------------------------------------------

execute if score @s yield_primary_damage matches 40 run say PRIMARY DAMAGE = 40

execute if score @s yield_primary_damage matches 40 as @e[type=#missile:valid_targets] if score @s target_id = #resolution_target target_id run damage @s 40 minecraft:generic