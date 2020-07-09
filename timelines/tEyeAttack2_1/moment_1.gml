///@desc Fire the laser

laser.fire()

laser_int = setInterval(self, function() {
	var target_dir = point_direction(x, y, oPlayer.x, oPlayer.y)
	laser.dir -= 3 * sign(angle_difference(laser.dir, target_dir))
	
	laser.fire()
}, 8)