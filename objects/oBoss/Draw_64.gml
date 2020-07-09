/// @desc

function draw_rectangle_texture(x1, y1, x2, y2, _texture) {
	sw = sprite_get_width(_texture)
	sh = sprite_get_height(_texture)
	
	texture = _texture
	
	for(var _yy = y1; _yy <= y2; _yy += sh) {
		for(var _xx = x1; _xx <= x2; _xx += sw) {
			draw_sprite(texture, 0, _xx, _yy)
		}
	}
}

function draw_healthbar_ext(x1, y1, x2, y2, amount, _texture) {
	//var wid = (x2 - x1) * value
	//var hei = (y2 - y1)

	draw_rectangle_texture(x1, y1, lerp(x1, x2, amount), y2, _texture)
}

#region Main hpbar

dw = display_get_gui_width()
dh = display_get_gui_height()

x1 = 128
//y1 = dh - 64
y1 = 16
x2 = dw - 128
//y2 = dh - 16
y2 = 64

pad = 6 // Padding

value = hp / max_hp


//draw_rectangle_color(x1-pad, y1-pad, x2+pad, y2+pad, c_white, c_white, c_white, c_white, true)
draw_healthbar_ext(x1, y1, x2, y2, value, sHpbar_texture3)

#endregion
#region Additional impact

if prev_hp_delay
	prev_hp_delay--
else if prev_hp > hp
	//prev_hp -= (max_prev_hp - hp) / prev_hp_time
	prev_hp -= prev_hp_speed
else {
	prev_hp = hp
	max_prev_hp = prev_hp
}

value2 = prev_hp / max_hp

x3 = lerp(x1, x2, value)
y3 = y1
x4 = lerp(x1, x2, value2)
y4 = y2

draw_rectangle_texture(x3, y3, x4, y4, sHpbar_texture2)



//if prev_hp2_delay
//	prev_hp2_delay--
//else if prev_hp2_alpha
//{
//	prev_hp2_alpha -= prev_hp2_fade
	
//	var value3 = prev_hp2 / max_hp

//	var x5 = lerp(x1, x2, value3)
//	var y5 = y2


//	draw_get()
//	draw_set_alpha(prev_hp2_alpha)

//	draw_rectangle_texture(x3, y3, x5, y5, sHpbar_texture1)

//	draw_reset()
//}

#endregion