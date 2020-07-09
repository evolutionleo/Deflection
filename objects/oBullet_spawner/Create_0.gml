/// @desc
shoot = function()
{	
	image_angle = dir
	shot = true
	
	var vx1 = camera_get_view_x(view_camera[0])
	var vy1 = camera_get_view_y(view_camera[0])
	
	var vx2 = vx1 + camera_get_view_width(view_camera[0])
	var vy2 = vy1 + camera_get_view_height(view_camera[0])
	
	if(x > vx1 and x < vx2 and y > vy1 and y < vy2) {
		audio_play_sound_mute(aShoot, 1, 0)
	}
	
	if !active
		return 100
	
	if lock_on
		dir = point_direction(x, y, oPlayer.x, oPlayer.y)
	
	var xx = x + lengthdir_x(radius, dir)
	var yy = y + lengthdir_y(radius, dir)
	
	bul = instance_create_layer(xx, yy, "Bullets", bullet_type)
	if lock_on
		bul.rotateTo(oPlayer.pos)
	else
		bul.setDirection(dir)
	
	props = new Map(props)
	props.ForEach(function(val, name) {
		variable_instance_set(bul, name, val)
	})
	props = props.content
}


//int = noone
//setTimeout(function() {
	int = setInterval(shoot, rate, {})
//}, 1)

shot = false