/// @desc

setSpeed(move.Multiplied(toVector2(sp)))

// Inherit the physics behaviour
event_inherited();


if owner == oPlayer
{
	image_index = 1
	image_speed = 0
}
else if hb_meeting(atk, oPlayer.def) and !hitByAttack.Exists(other)
{
	oPlayer.hit()
	hitByAttack.Append(other)
	
	onCollision()
}


atk.image_xscale = image_xscale
atk.image_yscale = image_yscale