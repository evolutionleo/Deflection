/// @desc
timer = 0


cutOutisdeView = function() {
	vw = camera_get_view_width(view_camera[0])
	vh = camera_get_view_height(view_camera[0])
	
	vx = camera_get_view_x(view_camera[0])// - vw / 2
	vy = camera_get_view_y(view_camera[0])// - vh / 2
	
	offset = 64

	//with(oHitbox) {
	//	var outside_view = (x < vx) or (x > vx + vw)    or (y < vy) or (y > vy + vh)
	//	var outside_map =  (x < 0)  or (x > room_width) or (y < 0)  or (y > room_height)
		
	//	if outside_view
	//	{
			
	//	}
	//	if outside_map
	//	{
	//		instance_destroy()
	//	}
	//}
	instance_deactivate_layer(layer_get_id("Enemies"))
	instance_deactivate_layer(layer_get_id("Effects"))
	instance_deactivate_layer(layer_get_id("Path"))
	instance_deactivate_layer(layer_get_id("Instances"))
	//instance_deactivate_layer(layer_get_id("Triggers"))
	instance_deactivate_layer(layer_get_id("Spikes"))
	instance_deactivate_layer(layer_get_id("Bullets"))
	
	instance_activate_region(vx-offset, vy-offset, vw+2*offset, vh+2*offset, true)
}