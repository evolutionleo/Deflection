_dependencies = [
	
]

function draw_get() {
	saved =
	{
		_halign: draw_get_halign(),
		_valign: draw_get_valign(),
		_color: draw_get_color(),
		_alpha: draw_get_alpha(),
		_font: draw_get_font()
	}
}

function draw_reset() {
	try {
		draw_set_alpha(saved._alpha)
		draw_set_color(saved._color)
		draw_set_font(saved._font)
		draw_set_halign(saved._halign)
		draw_set_valign(saved._valign)
	} catch(e) { }
}