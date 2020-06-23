/// @desc

var dw = display_get_gui_width()
var dh = display_get_gui_height()

draw_healthbar(64, dh-64, dw-64, dh-16, hp/max_hp*100, c_white, c_white, c_white, 0, 0, 0)