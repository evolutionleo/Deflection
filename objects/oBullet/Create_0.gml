/// @desc

// Inherit the physics
event_inherited();

owner = noone

hitByAttack = new Array()

#region Functions

deflect = function(obj) {
	//rotateFrom(obj.pos)
	//setDirection(point_direction(obj.x, obj.y, mouse_x, mouse_y))
	setDirection(obj.image_angle)
	sp *= 2
	
	owner = obj
	
	if variable_instance_exists(self, "bounces")
		bounces++
	
	setSpeed(move.Multiplied(toVector2(sp)))
}

onCollision = function() {
	int = setTimeout(self, function() {
		instance_destroy(self)
	}, 2)
}

#endregion

atk = hb_add(id,"atk", hBullet)


iframes = 5

ghost = false
antidash = false
antishield = false


//setTimeout(self, function() {
//}, 1)