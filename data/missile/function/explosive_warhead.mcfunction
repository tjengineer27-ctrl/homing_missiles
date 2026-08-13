# ============================================================
# HOMING MISSILE - EXPLOSIVE WARHEAD
# ============================================================

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
# KNOCKBACK TARGET DEBUG
# ------------------------------------------------------------

say KNOCKBACK DISPATCH REACHED

execute as @e[type=#missile:valid_targets] run say TARGET FOUND FOR KNOCKBACK

execute as @e[type=#missile:valid_targets] run tellraw @a [{"text":"[KB DEBUG] Target: ","color":"yellow"},{"selector":"@s"},{"text":" | AOE Controller ID: ","color":"white"},{"score":{"name":"@s","objective":"aoe_controller_id"},"color":"green"}]

tellraw @a [{"text":"[KB DEBUG] Active Controller ID: ","color":"white"},{"score":{"name":"#active_controller","objective":"controller_id"},"color":"aqua"}]

# ------------------------------------------------------------
# KNOCKBACK TARGETS
# ------------------------------------------------------------

execute if score #active_controller controller_id matches 1.. run say ACTIVE CONTROLLER HAS AN ID

execute as @e[type=#missile:valid_targets] run execute if score @s aoe_controller_id matches 1.. run say TARGET HAS A CONTROLLER ID

# ------------------------------------------------------------
# EXPLOSION FLASH
# ------------------------------------------------------------

particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1 force

# ------------------------------------------------------------
# THICK, SLOW-EXPANDING SMOKE CLOUD
# ------------------------------------------------------------

particle minecraft:campfire_signal_smoke ~ ~1 ~ 0.35 0.25 0.35 0.005 60 force

# ------------------------------------------------------------
# POWERFUL LAVA PARTICLE BURST
# ------------------------------------------------------------

particle minecraft:lava ~ ~1 ~ 0.9 0.9 0.9 0.35 40 force

# ------------------------------------------------------------
# SECONDARY POWERFUL LAVA BURST
# ------------------------------------------------------------

particle minecraft:lava ~ ~1 ~ 0.6 0.6 0.6 0.5 25 force

# ------------------------------------------------------------
# EXPLOSION SOUND
# ------------------------------------------------------------

execute at @s run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 1