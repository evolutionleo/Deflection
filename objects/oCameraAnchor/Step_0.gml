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
	cx = camera_get_view_x(cam)
	cy = camera_get_view_y(cam)
	
	cw = camera_get_view_width(cam)
	ch = camera_get_view_height(cam)
	
	tx = x-cam_width/2 // target_x
	ty = y-cam_height/2 // target_y
	
	cx = lerp(cx, tx, 1/20)
	cy = lerp(cy, ty, 1/20)
	

	cw = lerp(cw, cam_width, 1/20)
	ch = lerp(ch, cam_height, 1/20)
	
	
	dist = point_distance(cx, cy, tx, ty)
	global.camera_ready = dist < 64
	
	if !global.camera_ready
		oOptimization.cutOutisdeView()
	
	camera_set_view_pos(cam, cx, cy)
	camera_set_view_size(cam, cw, ch)
}