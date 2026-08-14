# ============================================================
# HOMING MISSILE - SHARED AOE DAMAGE
# ============================================================

say YIELD AOE DAMAGE ENTERED

scoreboard players operation #debug_aoe_damage debug_damage = @s yield_aoe_damage

# ------------------------------------------------------------
# LOW AOE DAMAGE
# ------------------------------------------------------------

execute if score @s yield_aoe_damage matches 40 run say AOE DAMAGE = 40

execute if score @s yield_aoe_damage matches 40 as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run damage @s 40 minecraft:generic

# ------------------------------------------------------------
# MEDIUM AOE DAMAGE
# ------------------------------------------------------------

execute if score @s yield_aoe_damage matches 80 run say AOE DAMAGE = 80

execute if score @s yield_aoe_damage matches 80 as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run damage @s 80 minecraft:generic

# ------------------------------------------------------------
# HIGH AOE DAMAGE
# ------------------------------------------------------------

execute if score @s yield_aoe_damage matches 160 run say AOE DAMAGE = 160

execute if score @s yield_aoe_damage matches 160 as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run damage @s 160 minecraft:generic