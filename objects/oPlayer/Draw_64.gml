/// @desc

xx = 32
yy = 32

display_set_gui_size(1920, 1080)

dw = display_get_gui_width()
dh = display_get_gui_height()

var scale = 4

for(var i = 0; i < ceil(hp); i++) {
	if i + .5 == hp {
		draw_sprite_ext(sLives, 1, xx, yy, scale, scale, 0, c_white, 1.0) // Halfs
	}
	else {
		draw_sprite_ext(sLives, 2, xx, yy, scale, scale, 0, c_white, 1.0) // Full hearts
	}
	
	xx += 68
}

for(var i = ceil(hp); i < max_hp; i++) {
	draw_sprite_ext(sLives, 0, xx, yy, scale, scale, 0, c_white, 1.0) // Emplty hearts
	xx += 68
}

yy += 68
xx = 16


draw_get()

draw_set_font(fPixel)
draw_set_color(c_white)


draw_set_valign(fa_top)

if global.timer_visible {
	draw_text(dw - 32 - string_width(oTimer.str), 32, oTimer.str)
	//draw_text(dw - 32, 32, oTimer.str)
}

yy += 68 

draw_set_halign(fa_left)
draw_set_valign(fa_middle)

//if debug_mode
	draw_text(xx, yy, se("fps: % (%)", fps, round(_fps_real)))

draw_reset()