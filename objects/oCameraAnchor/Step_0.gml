/// @desc

if active
{
	if follow_player
	{
		if follow_x
			x = oPlayer.x
		if follow_y
			y = oPlayer.y
	}

	cam = view_camera[0]
	var cx = camera_get_view_x(cam)
	var cy = camera_get_view_y(cam)
	
	var cw = camera_get_view_width(cam)
	var ch = camera_get_view_height(cam)
	
	var tx = x-cam_width/2 // target_x
	var ty = y-cam_height/2 // target_y
	
	cx = lerp(cx, tx, 1/20)
	cy = lerp(cy, ty, 1/20)
	

	cw = lerp(cw, cam_width, 1/20)
	ch = lerp(ch, cam_height, 1/20)
	
	
	var dist = point_distance(cx, cy, tx, ty)
	global.camera_ready = dist < 64
	
	
	camera_set_view_pos(cam, cx, cy)
	camera_set_view_size(cam, cw, ch)
}