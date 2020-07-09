/// @desc
try {
image_angle += angular_speed
image_alpha += alpha_speed
} catch(e) { }

//x += lengthdir_x(base_spd, direction)
//y += lengthdir_y(base_spd, direction)

if image_alpha <= 0
	instance_destroy()
else if max_alpha <= image_alpha {
	image_alpha = max_alpha
	alpha_speed = -.05
}