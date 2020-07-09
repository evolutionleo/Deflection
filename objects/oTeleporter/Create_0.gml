/// @desc
teleport = function(inst) {
	var can_teleport = false
	
	while(!can_teleport)
	{
		var next_id = portal_id + 1
		
		if next_id >= global.portals.Size {
			var next_id = 0
		}
		
		
		var next_portal = global.portals.Get(next_id)
		
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