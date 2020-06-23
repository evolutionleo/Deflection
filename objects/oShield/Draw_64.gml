/// @desc
var vw = display_get_gui_width()
var vh = display_get_gui_height()


if state == Active {
	var val = (max_active_time-active_time)/max_active_time*100
}
else {//if state == Inactive {
	var val = (max_cooldown-cooldown)/max_cooldown*100
}
//else {
//	var val = 0
//}

draw_healthbar(vw-64, 128, vw-8, vh/2, val, c_red, c_white, c_white, 3, 0, 0)