/// @desc

if global.camera_ready and global.next_camera == cam_id
{
	with oCameraAnchor
	{
		active = cam_id == other.cam_id
	}
}

//var active_camera = 0
//with(oCameraAnchor)
//	if active active_camera = cam_id


//show_debug_message(active_camera)