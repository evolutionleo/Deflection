/// @desc
if room == rWin and global.timer_visible
{
	draw_get()
	
	draw_set_halign(fa_right)
	draw_set_font(fTimer2)
	draw_text(room_width - 64, room_height - 64, str)
	
	draw_reset()
}