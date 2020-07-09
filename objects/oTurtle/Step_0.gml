/// @desc

velo.Zero()

if state == Walk
	applySpeed(base_spd.Multiplied(new Vector2(move.x, 0)))
else
	spd.x *= .95


if hb_meeting(def, oPlayer.atk) and (oPlayer.spd.y > 0 or oPlayer.prev_spd > 0)
{
	hit()
	oPlayer.jump(oPlayer.bounce_vec)
	oPlayer.air_jumps = oPlayer.max_air_jumps
}
else if hb_meeting(atk, oPlayer.def) and state == Attack
{
	oPlayer.hit(damage, knockback)
}


if !alarm[1] and state == Walk and distance_to_object(oPlayer) < 256 {
	state = AttackStart
}

// Inherit the parent event
event_inherited();

image_xscale = -image_xscale