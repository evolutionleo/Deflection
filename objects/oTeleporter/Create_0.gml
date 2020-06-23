/// @desc
teleport = function(inst) {
	var can_teleport = false
	var next_id = portal_id + 1
	
	while(!can_teleport)
	{	
		try {
			var next_portal = global.portals.Get(next_id)
		}
		catch(err) {
			next_portal = global.portals.Get(0)
		}
		
		//show_message(global.portals)
		//show_message(next_portal)
		
		if next_portal == self
			return -1
		
		if next_portal.active
			can_teleport = true
		
		next_id++
	}
	
	var next_camera = instance_nearest(next_portal.x, next_portal.y, oCameraAnchor)
	global.next_camera = next_camera
	with(oCameraAnchor)
		active = false
	next_camera.active = true
	
	
	inst.pos.x = next_portal.x
	inst.pos.y = next_portal.y
}