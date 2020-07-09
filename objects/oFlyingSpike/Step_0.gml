/// @desc

dir = point_direction(0, 0, spd.x, spd.y)

if dir != 0
	image_angle = dir + 90

event_inherited()

applySpeed(grv)