/// @desc
draw_get()

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fMenu)
draw_set_color(c_white)

if !active
	draw_set_alpha(.5)

draw_text(bbox_center, bbox_middle+3, text)

draw_reset()