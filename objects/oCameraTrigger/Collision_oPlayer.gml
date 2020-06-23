/// @desc

if global.camera_ready
{
	with oCameraAnchor
	{
		active = cam_id == other.cam_id
	}
}
else
{
	global.next_camera = cam_id
}