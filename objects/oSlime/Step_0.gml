/// @desc

velo.Zero()
applySpeed(base_spd.Multiplied(new Vector2(move.x, 0)))


//iframes--

if distance_to_object(oPlayer) < 64
{
	if (oPlayer.spd.y > 0 or oPlayer.prev_spd.y > 0) and (hb_meeting(def, oPlayer.atk))
	{
		hit()
		oPlayer.jump(oPlayer.bounce_vec)
		oPlayer.air_jumps = oPlayer.max_air_jumps
		
		//iframes = max_iframes
	}
	else if hb_meeting(atk, oPlayer.def)
	{
		//create_text({text: string(oPlayer.spd.y), font: fPixel, y: y-48})
		oPlayer.hit(damage, knockback)
		
		//iframes = max_iframes
	}
}

// Inherit the parent event
event_inherited();