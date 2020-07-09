/// @desc
dw = display_get_gui_width()
dh = display_get_gui_height()

if debug_mode {
	draw_get()
	
	draw_set_halign(fa_right)
	draw_set_valign(fa_bottom)
	
	draw_text(dw - 32, dh - 32, string(Power))
	
	draw_reset()
}