# ============================================================
# EXPLOSIVE WARHEAD
# ============================================================

tellraw @a {"text":"[EXPLOSIVE DEBUG] EXPLOSIVE WARHEAD ENTERED","color":"gold"}

# ------------------------------------------------------------
# VERIFY YIELD
# ------------------------------------------------------------

execute if score @s warhead_yield matches 1 run tellraw @a {"text":"[EXPLOSIVE DEBUG] LOW YIELD SELECTED","color":"yellow"}

# ------------------------------------------------------------
# LOAD THIS CONTROLLER'S PRIMARY TARGET ID
# ------------------------------------------------------------

scoreboard players operation #resolution_target target_id = @s impact_target_id

# ------------------------------------------------------------
# KNOCKBACK - STORE EXPLOSION POSITION
# ------------------------------------------------------------

execute store result score #controller_x guidance_cx run data get entity @s Pos[0] 1000
execute store result score #controller_y guidance_cy run data get entity @s Pos[1] 1000
execute store result score #controller_z guidance_cz run data get entity @s Pos[2] 1000

# ------------------------------------------------------------
# LOAD KNOCKBACK SETTINGS FROM CONTROLLER
# ------------------------------------------------------------

scoreboard players operation #active_yield_knockback knockback_scale = @s yield_knockback

# LOW = x1.00
# MEDIUM = x1.75
# HIGH = x2.50

scoreboard players set #knockback_multiplier knockback_scale 1000

execute if score @s warhead_yield matches 2 run scoreboard players set #knockback_multiplier knockback_scale 1750
execute if score @s warhead_yield matches 3 run scoreboard players set #knockback_multiplier knockback_scale 2500

# Calculate the final yield-based knockback strength

scoreboard players operation #active_yield_knockback knockback_scale *= #knockback_multiplier knockback_scale
scoreboard players operation #active_yield_knockback knockback_scale /= #scale_1000 knockback_scale

# ============================================================
# KNOCKBACK DISPATCH
# ============================================================

execute as @e[type=#missile:valid_targets] run scoreboard players get @s aoe_controller_id

scoreboard players get #active_controller controller_id

execute as @e[type=#missile:valid_targets] if score @s aoe_controller_id = #active_controller controller_id run function missile:knockback_target

# ------------------------------------------------------------
# PRIMARY TARGET DAMAGE
# ------------------------------------------------------------

# LOW    = 10
# MEDIUM = 20
# HIGH   = 40

function missile:yield_damage

# ------------------------------------------------------------
# AOE DAMAGE
# ------------------------------------------------------------

# LOW    = 40
# MEDIUM = 80
# HIGH   = 160

function missile:yield_aoe_damage

# ------------------------------------------------------------
# EXPLOSION EFFECTS
# ------------------------------------------------------------

# ============================================================
# LOW YIELD
# ============================================================

execute if score @s warhead_yield matches 1 run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1 force

execute if score @s warhead_yield matches 1 run particle minecraft:campfire_signal_smoke ~ ~1 ~ 0.35 0.25 0.35 0.005 60 force

execute if score @s warhead_yield matches 1 run particle minecraft:lava ~ ~1 ~ 0.9 0.9 0.9 0.35 40 force

execute if score @s warhead_yield matches 1 run particle minecraft:lava ~ ~1 ~ 0.6 0.6 0.6 0.5 25 force


# ============================================================
# MEDIUM YIELD
# ============================================================

execute if score @s warhead_yield matches 2 run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 2 force

execute if score @s warhead_yield matches 2 run particle minecraft:campfire_signal_smoke ~ ~1 ~ 0.4 0.3 0.4 0.005 100 force

execute if score @s warhead_yield matches 2 run particle minecraft:lava ~ ~1 ~ 1.0 1.0 1.0 0.35 70 force

execute if score @s warhead_yield matches 2 run particle minecraft:lava ~ ~1 ~ 0.7 0.7 0.7 0.5 45 force


# ============================================================
# HIGH YIELD
# ============================================================

execute if score @s warhead_yield matches 3 run particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 3 force

execute if score @s warhead_yield matches 3 run particle minecraft:campfire_signal_smoke ~ ~1 ~ 0.5 0.35 0.5 0.005 150 force

execute if score @s warhead_yield matches 3 run particle minecraft:lava ~ ~1 ~ 1.2 1.2 1.2 0.35 100 force

execute if score @s warhead_yield matches 3 run particle minecraft:lava ~ ~1 ~ 0.8 0.8 0.8 0.5 70 force


# ------------------------------------------------------------
# EXPLOSION SOUND
# ------------------------------------------------------------

execute if score @s warhead_yield matches 1 run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 1

execute if score @s warhead_yield matches 2 run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1.25 1

execute if score @s warhead_yield matches 3 run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1.5 1