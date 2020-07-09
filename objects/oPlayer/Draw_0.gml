/// @desc


if !blinking
	draw_self()

draw_set_halign(fa_center)
//draw_text(x, y-64, )

//draw_text(x, y-96, )

if max_dashes
{
	var active = dashes < max_dashes
	if my_shield and state != ShieldSlide {
		var dir = my_shield.image_angle
		var xx = my_shield.x + lengthdir_x(8, dir)
		var yy = my_shield.y + lengthdir_y(8, dir)
	}
	else {
		var dir = point_direction(pos.x, pos.y, mouse_x, mouse_y)
		var xx = pos.x + lengthdir_x(32, dir)
		var yy = pos.y + lengthdir_y(32, dir)
	}
	
	draw_sprite_ext(sDashArrow, active, xx, yy, .5, .5, dir, c_white, 1.0)
}