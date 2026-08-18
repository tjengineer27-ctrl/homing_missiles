# ============================================================
# HOMING MISSILE - GUIDANCE MOVEMENT
# ============================================================
#
# PN-based velocity integration.
#
# The proportional-navigation system calculates:
#
#   pn_accel_x
#   pn_accel_y
#   pn_accel_z
#
# These values are NOT applied directly to velocity.
#
# Instead:
#
#   1. Start with current normalized direction.
#   2. Apply a small PN correction.
#   3. Normalize the resulting direction.
#   4. Restore the missile's existing speed.
#   5. Move the missile using the resulting velocity.
#
# This allows PN to steer the missile without directly
# changing its overall speed.
#
# ============================================================


# ============================================================
# ONLY MOVE ACTIVE MISSILES
# ============================================================

execute unless entity @s[tag=guidance_at_target] if entity @e[type=#missile:valid_targets,tag=guidance_move_target,limit=1] run function missile:movement_guidance_active