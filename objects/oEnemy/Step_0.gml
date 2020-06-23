/// @desc
#region Counterlag
ot = 1000000/60
counterlag = delta_time/ot
#endregion
#region Rotation

#macro rotmode_free 0
#macro rotmode_flip 1
#macro rotmode_freeflip 2
#macro rotmode_fixed 3

image_angle = point_direction(0, 0, move.x, move.y)

switch(rotation_mode) {
	case rotmode_free:
		// Leave as it is
		break
	case rotmode_freeflip:
		if(image_angle > 90 and image_angle < 270)
		{
			image_angle -= 180
			image_xscale = -abs(image_xscale)
		}
		else
		{
			image_xscale = abs(image_xscale)
		}
		break
	case rotmode_fixed:
		image_angle = 0
		break
	case rotmode_flip:
		if(image_angle > 90 and image_angle < 270)
		{
			image_xscale = -abs(image_xscale)
		}
		else
		{
			image_xscale = abs(image_xscale)
		}
		image_angle = 0
		break
}

#endregion

velo.Add(grv)

spd.Add(velo.Multiplied(toVector2(counterlag)))

spd.Clamp(min_spd, max_spd)

if(!ignoring_walls)
	collision()
else
	pos.Add(spd)


x = pos.x
y = pos.y