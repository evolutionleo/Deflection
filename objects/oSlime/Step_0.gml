/// @desc

velo.Zero()
applySpeed(base_spd.Multiplied(new Vector2(move.x, 0)))


//iframes--

//if !iframes
//{
	if hb_meeting(def, oPlayer.atk) and (oPlayer.prev_spd.y > 0 or oPlayer.spd.y > 0)
	{
		hit()
		oPlayer.jump(oPlayer.bounce_vec)
		oPlayer.air_jumps = oPlayer.max_air_jumps
		
		//iframes = max_iframes
	}
	else if hb_meeting(atk, oPlayer.def)
	{
		oPlayer.hit(damage, knockback)
		
		//iframes = max_iframes
	}
//}

// Inherit the parent event
event_inherited();