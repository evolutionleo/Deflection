/// @desc

var on_mouse = bbox_left <= mx && bbox_right >= mx && bbox_top < my && bbox_bottom > my

if on_mouse {
	onHover()
	
	if active
	{
		if mouse_check_button_released(mb_left)
			onClick()
		else if mouse_check_button(mb_left)
			onHold()
	}
}
else {
	onDefault()
}