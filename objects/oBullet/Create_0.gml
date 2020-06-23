/// @desc

// Inherit the physics
event_inherited();

owner = noone

hitByAttack = new Array()

deflect = function(obj) {
	//rotateFrom(obj.pos)
	setDirection(point_direction(obj.x, obj.y, mouse_x, mouse_y))
	sp *= 2
	
	owner = obj
	
	if variable_instance_exists(self, "bounces")
		bounces++
}


atk = hb_add("atk", hBullet)


iframes = 5

//setTimeout(function() {
	onCollision = method(self, function() {
		setTimeout(method(self, function() {
			instance_destroy()
		}),
			1, {})
	})
//}, 1)
//}, iframes)