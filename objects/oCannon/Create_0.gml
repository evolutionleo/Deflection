/// @desc
shoot = function()
{	
	image_angle = dir
	//shot = true
	
	if !active
		return 0
	
	vx1 = camera_get_view_x(view_camera[0])
	vy1 = camera_get_view_y(view_camera[0])
	
	vx2 = vx1 + camera_get_view_width(view_camera[0])
	vy2 = vy1 + camera_get_view_height(view_camera[0])
	
	if(x > vx1 and x < vx2 and y > vy1 and y < vy2) {
		audio_play_sound_mute(aShoot, 1, 0)
	}
	
	if lock_on
		dir = point_direction(x, y, oPlayer.x, oPlayer.y)
	
	xx = x + lengthdir_x(radius, dir)
	yy = y + lengthdir_y(radius, dir)
	
	bul = instance_create_layer(xx, yy, "Bullets", bullet_type)
	if lock_on
		bul.rotateTo(oPlayer.pos)
	else
		bul.setDirection(dir)
	
	map = new Map(_props)
	map.ForEach(function(val, name) {
		variable_instance_set(bul, name, val)
	})
	delete map
}

//if active
	int = setInterval(self, shoot, rate)
//else
//	int = undefined

event_inherited()

onActivation = function() {
	//if !is_undefined(int)
	//	stopInterval(int)
	
	//int = setInterval(self, shoot, rate)
}
onDeactivation = function() {
	//if !is_undefined(int)
	//	stopInterval(int)
}