/// @desc
image_angle += _angular_speed
image_alpha -= alpha_speed

x += lengthdir_x(_base_spd, direction)
y += lengthdir_y(_base_spd, direction)

if image_alpha <= 0
	instance_destroy()
else if image_alpha <= .5
	alpha_speed = .1