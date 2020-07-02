/// @desc

#region Key physics setup

pos = new Vector2(x, y)

spd = new Vector2(0, 0)
prev_spd = new Vector2(0, 0)
fraction = new Vector2(0, 0)

velo = new Vector2(0, 0)

move = new Vector2(0, 0)
grv = new Vector2(xgrv, ygrv)

#endregion
#region Functions

pointGround = function(_x, _y) {
	//static tilemap1 = layer_tilemap_get_id(layer_get_id("Wall"))
	//var tile1 = tilemap_get_at_pixel(tilemap1, _x, _y)
	
	//static tilemap2 = layer_tilemap_get_id(layer_get_id("HiddenWall"))
	//var tile2 = tilemap_get_at_pixel(tilemap2, _x, _y)
	
	//return sign(tile1) or sign(tile2)
	
	var tilemap = layer_tilemap_get_id(layer_get_id("Tiles"))
	var tile = tilemap_get_at_pixel(tilemap, _x, _y)
	
	var grid = global.collision_map.Get(tile)
	
	var xx = _x % 16
	var yy = _y % 16
	
	
	return grid[xx][yy]
}

///@function meetingGround(x, y)
///@param	 {real} x
///@param	 {real} y
meetingGround = function(_x, _y) { 
	var left = floor(bbox_left-x+_x)
	var right = ceil(bbox_right-x+_x)
	var top = floor(bbox_top-y+_y)
	var bottom = ceil(bbox_bottom-y+_y)
	//Awful slow implementation
	
	//for(var xx = left; xx <= right; xx++) {
	//	for(var yy = top; yy <= bottom; yy++) {
	//		if pointGround(xx, yy)
	//			return true
	//	}
	//}
	//return false
	
	// Faster, but worse implementation
	return pointGround(left, top) || pointGround(right, top) || pointGround(left, bottom) || pointGround(right, bottom)
}

///@function	collision()
///@description Corrects position to not collide with anything
collision = function() {
	var colliding = false

	fraction.x = spd.x - (floor(abs(spd.x)) * sign(spd.x))
	fraction.y = spd.y - (floor(abs(spd.y)) * sign(spd.y))

	spd.Subtract(fraction)
	
	if meetingGround(pos.x + spd.x + sign(spd.x), pos.y)
	{
		while !meetingGround(pos.x + sign(spd.x), pos.y)
		{
			pos.x += sign(spd.x)
		}
		prev_spd.x = spd.x - grv.x
		
		colliding = true
		spd.x = 0
		velo.x = 0
		fraction.x = 0
	}
	pos.x += spd.x
	
	if meetingGround(pos.x, pos.y + spd.y + sign(spd.y))
	{
		while !meetingGround(pos.x, pos.y + sign(spd.y))
		{
			pos.y += sign(spd.y)
		}
		prev_spd.y = spd.y - grv.y
		
		colliding = true
		spd.y = 0
		velo.y = 0
		fraction.y = 0
	}
	pos.y += spd.y
	
	
	
	spd.Add(fraction)
	
	if colliding
		onCollision()
}

///@function applyVelocity(velo)
///@param	{Vector2} velo
applyVelocity = function(amount) {
	self.velo.Add(amount)
	return self.velo
}

///@function applySpeed(spd)
///@param	{Vector2} spd
applySpeed = function(amount) {
	self.spd.Add(amount)
	return self.spd
}

///@function setSpeed(spd)
///@param	{Vector2} spd
setSpeed = function(amount) {
	self.spd = amount
	return self.spd
}

///@function setVelocity(spd)
///@param	{Vector2} spd
setVelocity = function(amount) {
	self.velo = amount
	return self.velo
}

///@function rotateTo(pos)
///@param	 {Vector2} pos
rotateTo = function(pos) {
	var dir = point_direction(x, y, pos.x, pos.y)
	move.x = lengthdir_x(1, dir)
	move.y = lengthdir_y(1, dir)
}

///@function setDirection(dir)
///@param	 {real} dir
setDirection = function(dir) {
	move.x = lengthdir_x(1, dir)
	move.y = lengthdir_y(1, dir)
}

///@function rotateFrom(pos)
///@param	 {Vector2} pos
rotateFrom = function(pos) {
	var dir = point_direction(pos.x, pos.y, x, y)
	move.x = lengthdir_x(1, dir)
	move.y = lengthdir_y(1, dir)
}

onCollision = function() {
	
}
#endregion