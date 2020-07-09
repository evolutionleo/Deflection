/// @desc

if object_index != oFlyingSpike {
	if antidash
		spr = sAntidashBullet
	else if antishield
		spr = sAntishieldBullet
	else
		spr = sBullet
	
	if sprite_index != spr {
		sprite_index = spr
		image_index = 0
	}
	
	
	setSpeed(move.Multiplied(toVector2(sp)))
	
}

// Inherit the physics behaviour
event_inherited();


//collision()

if owner == oPlayer
{
	sprite_index = sBullet
	image_index = 1
	image_speed = 0
}
else if distance_to_object(oPlayer) < 32 and !hitByAttack.Exists(oPlayer) and hb_meeting(atk, oPlayer.def)
{
	if antidash and (oPlayer.state == Dash or oPlayer.buffer.afterdash)
		oPlayer.buffer.iframes = 0
	
	if !oPlayer.isInvincible() {
		//onCollision()
		hitByAttack.Append(oPlayer)
	}
	
	oPlayer.hit()
}