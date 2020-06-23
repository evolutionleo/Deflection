/// @desc

var xx = 32
var yy = 32

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

draw_get()

draw_set_font(fDebug1)
draw_text(xx, yy, "")


draw_reset()