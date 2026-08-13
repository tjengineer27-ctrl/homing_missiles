# ============================================================
# HOMING MISSILE - CALCULATE WARHEAD YIELD
# ============================================================

# ------------------------------------------------------------
# CLEAR PREVIOUS CALCULATED VALUES
# ------------------------------------------------------------

scoreboard players set @s yield_radius 0
scoreboard players set @s yield_primary_damage 0
scoreboard players set @s yield_aoe_damage 0
scoreboard players set @s yield_knockback 0
scoreboard players set @s yield_duration 0
scoreboard players set @s yield_duration_ticks 0
scoreboard players set @s yield_particle_scale 0

# ------------------------------------------------------------
# LOW YIELD
# ------------------------------------------------------------

execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_radius 10
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_primary_damage 10
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_aoe_damage 40
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_knockback 1000
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_duration 20
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_duration_ticks 400
execute if score @s warhead_yield matches 1 run scoreboard players set @s yield_particle_scale 1

# ------------------------------------------------------------
# MEDIUM YIELD
# ------------------------------------------------------------

execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_radius 20
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_primary_damage 20
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_aoe_damage 80
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_knockback 1000
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_duration 40
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_duration_ticks 800
execute if score @s warhead_yield matches 2 run scoreboard players set @s yield_particle_scale 2

# ------------------------------------------------------------
# HIGH YIELD
# ------------------------------------------------------------

execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_radius 40
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_primary_damage 40
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_aoe_damage 160
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_knockback 1000
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_duration 80
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_duration_ticks 1600
execute if score @s warhead_yield matches 3 run scoreboard players set @s yield_particle_scale 3

# ------------------------------------------------------------
# MARK YIELD CALCULATION COMPLETE
# ------------------------------------------------------------

tag @s add yield_calculated