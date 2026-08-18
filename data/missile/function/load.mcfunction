# ============================================================
# TARGET ID SYSTEM
# ============================================================

scoreboard objectives add target_id dummy
scoreboard objectives add missile_target dummy
scoreboard objectives add tracker_target dummy

# Target position storage

scoreboard objectives add target_x dummy
scoreboard objectives add target_y dummy
scoreboard objectives add target_z dummy

# Global counter

execute unless score #next_target_id target_id matches 0.. run scoreboard players set #next_target_id target_id 0

# Temporary target-resolution holder

execute unless score #resolution_target target_id matches 0.. run scoreboard players set #resolution_target target_id 0


# ============================================================
# CONTROLLER ID SYSTEM
# ============================================================

scoreboard objectives add controller_id dummy
scoreboard objectives add missile_controller_id dummy


# ============================================================
# TRACKER -> CONTROLLER RELATIONSHIP
# ============================================================

scoreboard objectives add tracker_controller_id dummy
scoreboard objectives add visual_controller_id dummy

scoreboard objectives add missile_x dummy
scoreboard objectives add missile_y dummy
scoreboard objectives add missile_z dummy

scoreboard objectives add missile_prev_x dummy
scoreboard objectives add missile_prev_y dummy
scoreboard objectives add missile_prev_z dummy

scoreboard objectives add missile_vx dummy
scoreboard objectives add missile_vy dummy
scoreboard objectives add missile_vz dummy


# ============================================================
# GUIDANCE VECTOR
# ============================================================

scoreboard objectives add guidance_dx dummy
scoreboard objectives add guidance_dy dummy
scoreboard objectives add guidance_dz dummy

scoreboard objectives add guidance_prev_dx dummy
scoreboard objectives add guidance_prev_dy dummy
scoreboard objectives add guidance_prev_dz dummy

scoreboard objectives add guidance_rel_vx dummy
scoreboard objectives add guidance_rel_vy dummy
scoreboard objectives add guidance_rel_vz dummy


# ============================================================
# PROPORTIONAL NAVIGATION
# ============================================================

scoreboard objectives add pn_los_x dummy
scoreboard objectives add pn_los_y dummy
scoreboard objectives add pn_los_z dummy

scoreboard objectives add pn_accel_x dummy
scoreboard objectives add pn_accel_y dummy
scoreboard objectives add pn_accel_z dummy

scoreboard objectives add pn_scale dummy

scoreboard players set #pn_navigation_gain pn_scale 4000
scoreboard players set #pn_rate_scale pn_scale 1000

scoreboard objectives add pn_speed_scale dummy

scoreboard objectives add pn_dir_x dummy
scoreboard objectives add pn_dir_y dummy
scoreboard objectives add pn_dir_z dummy

scoreboard players set #negative_one pn_scale -1
scoreboard players set #pn_direction_scale pn_scale 1000
scoreboard players set #pn_math pn_scale 1

# IMPORTANT:
# Smaller value = stronger steering response.
#
# 1000  = very weak / often rounds away
# 100   = useful initial testing value
# 50    = stronger
# 25    = very strong

scoreboard players set #pn_turn_scale pn_scale 100


# ============================================================
# PN VECTOR / MOVEMENT STATE
# ============================================================

scoreboard objectives add missile_speed dummy

scoreboard objectives add pn_dx dummy
scoreboard objectives add pn_dy dummy
scoreboard objectives add pn_dz dummy

scoreboard objectives add pn_range_sq dummy
scoreboard objectives add pn_closing_speed dummy

# Newly calculated direction

scoreboard objectives add pn_new_x dummy
scoreboard objectives add pn_new_y dummy
scoreboard objectives add pn_new_z dummy

scoreboard objectives add pn_new_scale dummy

# Final movement vector

scoreboard objectives add pn_move_x dummy
scoreboard objectives add pn_move_y dummy
scoreboard objectives add pn_move_z dummy

scoreboard objectives add pn_move_active dummy


# ============================================================
# GUIDANCE POINT SYSTEM
# ============================================================

scoreboard objectives add guidance_point_controller_id dummy

scoreboard objectives add pn_point_x dummy
scoreboard objectives add pn_point_y dummy
scoreboard objectives add pn_point_z dummy

scoreboard players set #pn_lookahead pn_scale 10

scoreboard players operation #active_controller_point_x pn_point_x = @s pn_point_x
scoreboard players operation #active_controller_point_y pn_point_y = @s pn_point_y
scoreboard players operation #active_controller_point_z pn_point_z = @s pn_point_z

scoreboard players set #active_missile_vx missile_vx 0
scoreboard players set #active_missile_vy missile_vy 0
scoreboard players set #active_missile_vz missile_vz 0


# ============================================================
# GUIDANCE POSITION / DISTANCE
# ============================================================

scoreboard objectives add guidance_cx dummy
scoreboard objectives add guidance_cy dummy
scoreboard objectives add guidance_cz dummy

scoreboard objectives add guidance_tx dummy
scoreboard objectives add guidance_ty dummy
scoreboard objectives add guidance_tz dummy

scoreboard objectives add guidance_dist_x dummy
scoreboard objectives add guidance_dist_y dummy
scoreboard objectives add guidance_dist_z dummy

scoreboard objectives add guidance_distance dummy
scoreboard objectives add guidance_scale dummy

scoreboard objectives add guidance_in_range dummy

scoreboard objectives add impact_target_id dummy

scoreboard objectives add aoe_controller_id dummy


# ============================================================
# KNOCKBACK SYSTEM
# ============================================================

scoreboard objectives add knockback_dx dummy
scoreboard objectives add knockback_dy dummy
scoreboard objectives add knockback_dz dummy

scoreboard objectives add knockback_vx dummy
scoreboard objectives add knockback_vy dummy
scoreboard objectives add knockback_vz dummy

scoreboard objectives add knockback_scale dummy
scoreboard objectives add knockback_math dummy
scoreboard objectives add knockback_distance dummy
scoreboard objectives add knockback_magnitude dummy

scoreboard players set #scale_1000 knockback_scale 1000

# Upward explosion bias

scoreboard players set #knockback_upward_bias knockback_scale 500


# ============================================================
# WARHEAD SELECTION SYSTEM
# ============================================================

scoreboard objectives add warhead_type dummy
scoreboard objectives add potion_type dummy


# ============================================================
# CROSSHAIR TARGETING SYSTEM
# ============================================================

scoreboard objectives add crosshair_target_id dummy

team add missile_red_target
team modify missile_red_target color red


# ============================================================
# WARHEAD YIELD SYSTEM
# ============================================================

scoreboard objectives add warhead_yield dummy

scoreboard objectives add yield_radius dummy
scoreboard objectives add yield_primary_damage dummy
scoreboard objectives add yield_aoe_damage dummy
scoreboard objectives add yield_duration dummy
scoreboard objectives add yield_duration_ticks dummy
scoreboard objectives add yield_particle_scale dummy
scoreboard objectives add yield_knockback dummy


# ============================================================
# AOE DETECTION SYSTEM
# ============================================================

scoreboard objectives add aoe_dx dummy
scoreboard objectives add aoe_dy dummy
scoreboard objectives add aoe_dz dummy

scoreboard objectives add aoe_distance dummy
scoreboard objectives add aoe_radius_squared dummy

scoreboard objectives add aoe_target_x dummy
scoreboard objectives add aoe_target_y dummy
scoreboard objectives add aoe_target_z dummy
scoreboard objectives add aoe_math dummy


# ============================================================
# MISSILE CONFIGURATION
# ============================================================

scoreboard objectives add missile_config dummy

scoreboard players set #config_status missile_config 0
scoreboard players set #config_warhead missile_config 1
scoreboard players set #config_yield missile_config 1
scoreboard players set #config_potion missile_config 1

scoreboard players set #base_knockback knockback_scale 0
scoreboard players set #active_aoe_radius aoe_radius_squared 0

scoreboard players set #aoe_scale aoe_radius_squared 1000


# ============================================================
# DEBUG
# ============================================================

scoreboard objectives add debug_damage dummy

scoreboard players set #scale_2 knockback_scale 2


# ============================================================
# GLOBAL CONTROLLER COUNTER
# ============================================================

scoreboard players set #next_controller_id controller_id 0