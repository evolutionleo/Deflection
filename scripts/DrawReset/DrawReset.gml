_dependencies = [
	
]

function draw_get() {
	saved = {
		halign: draw_get_halign(),
		valign: draw_get_valign(),
		color: draw_get_color(),
		alpha: draw_get_alpha(),
		font: draw_get_font()
	}
}

function draw_reset() {
	draw_set_alpha(saved.alpha)
	draw_set_color(saved.color)
	draw_set_font(saved.font)
	draw_set_halign(saved.halign)
	draw_set_valign(saved.valign)
}