/// @desc
image_angle += angular_speed
image_alpha -= alpha_speed

x += lengthdir_x(base_spd, direction)
y += lengthdir_y(base_spd, direction)

if image_alpha <= 0
	instance_destroy()
