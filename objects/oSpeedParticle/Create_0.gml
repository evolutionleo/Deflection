/// @desc
//max_alpha = random_range(.5, .8)
max_alpha = .8
alpha_speed = .1
image_alpha = random_range(.2, .4)

image_index = irandom(image_number)

//scale = random_range(1, 3)
scale = oPlayer.image_xscale
image_xscale = scale
image_yscale = scale

image_angle = 0
angular_speed = 0


//base_spd = random_range(2, 20)
//base_spd = random_range(.3, 2)
base_spd = 0


//offx = x - camera_get_view_x(view_camera[0])
//offy = y - camera_get_view_y(view_camera[0])