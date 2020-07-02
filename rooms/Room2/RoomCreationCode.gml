//gml_release_mode(true)


if debug_mode
{
	oPlayer.upgrades.Append("Double Jump")
	oPlayer.upgrades.Append("Shield")
	oPlayer.updateUpgrades()
}


global.camera_ready = false
global.next_camera = 0

with(oCameraAnchor) {
	if active {
		global.next_camera = cam_id
		camera_set_view_pos(view_camera[0], x-cam_width/2 - cam_width/2, y-cam_height/2 - cam_height)
		camera_set_view_size(view_camera[0], cam_width, cam_height)
	}
}