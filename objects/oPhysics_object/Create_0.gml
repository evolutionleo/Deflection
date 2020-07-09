/// @desc

#region Key physics setup

pos = new Vector2(x, y)

spd = new Vector2(0, 0)
prev_spd = new Vector2(spd.x, spd.y)
fraction = new Vector2(0, 0)

velo = new Vector2(0, 0)

move = new Vector2(0, 0)
grv = new Vector2(xgrv, ygrv)

#endregion
#region Functions

pointGround = function(_x, _y) {
	if _x > room_width || _y > room_height || _x < 0 || _y < 0
		return 0
	
	tilemap = layer_tilemap_get_id(layer_get_id("Wall"))
	tilemap2 = layer_tilemap_get_id(layer_get_id("HiddenWall"))
	tilemap3 = layer_tilemap_get_id(layer_get_id("Dreamblock"))
	tile = tile_get_index(tilemap_get_at_pixel(tilemap, _x, _y))
	tile2 = tile_get_index(tilemap_get_at_pixel(tilemap2, _x, _y))
	tile3 = tile_get_index(tilemap_get_at_pixel(tilemap3, _x, _y))
	
	//show_debug_message(tile)
	if tile != 0 and tile != 8 and tile != 10 { // Numbers represent tiles w/o hitbox
	//if tile_get_index(tilemap_get_at_pixel(tilemap, _x, _y)) {
		//var grid = global.collision_map.Get(tile)
		
		//var xx = _x % 16
		//var yy = _y % 16
		
		//try {
		//	return grid[xx][yy]
		//} catch(e) { return 0 }
		oGround.x = _x div 16 * 16
		oGround.y = _y div 16 * 16
		
		oGround.image_index = tile
		
		return position_meeting(_x, _y, oGround)
	}
	else if tile2 != 0 and tile2 != 8 and tile2 != 10 { // Numbers represent tiles w/o hitbox
		
		//var grid = global.collision_map.Get(tile2)
		
		//var xx = _x % 16
		//var yy = _y % 16
		
		//try {
		//	return grid[xx][yy]
		//} catch(e) { return 0 }
		oGround.x = _x div 16 * 16
		oGround.y = _y div 16 * 16
		
		oGround.image_index = tile2
		
		return position_meeting(_x, _y, oGround)
	}
	//else if position_meeting(_x, _y, oSolid) {
	else if tile3 and (state != Dash and buffer.afterdash <= 0)
	{
		return true
	}
	else if object_index == oPlayer {
		if state == ShieldSlide and position_meeting(_x, _y, oSpike) {
			return true
		}
		else {
			return false
		}
	}
	else
		return false
}

///@function meetingGround(x, y)
///@param	 {real} x
///@param	 {real} y
meetingGround = function(_x, _y) {
	#region Get sides
	
	left = floor(bbox_left-x+_x)
	right = ceil(bbox_right-x+_x)
	top = floor(bbox_top-y+_y)
	bottom = ceil(bbox_bottom-y+_y)
	
	#endregion
	#region Quit!
	if left < 0 || right > room_width || top < 0 || bottom  > room_height
		return 0
	#endregion
	if object_index == oPlayer {
	#region Check every [second] pixel
	
	//var delta = 2
	delta = 2
	
	//if pointGround(left, top)
	//|| pointGround(right, top)
	//|| pointGround(left, bottom)
	//|| pointGround(right, bottom)
	//	return true
	
	for(xx = left; xx <= right; xx += delta) {
		for(yy = top; yy <= bottom; yy += delta) {
			if pointGround(xx, yy)
				return true
		}
	}
	
	#endregion
	#region //Only check edges
	
	//delta = 4 // Yep, that's pretty huge delta
	
	//yy = top
	//for(xx = left; xx <= right; xx += delta)
	//{
	//	if pointGround(xx, yy)
	//		return true
	//}
	
	//yy = bottom
	//repeat(ceil(abs(spd.y))) {
	//	for(xx = left; xx <= right; xx += delta)
	//	{
	//		if pointGround(xx, yy)
	//			return true
	//	}
	//	yy--
	//}
	
	//xx = left
	//for(yy = top; yy <= bottom; yy += delta)
	//{
	//	if pointGround(xx, yy)
	//		return true
	//}
	
	//xx = right
	//for(yy = top; yy <= bottom; yy += delta)
	//{
	//	if pointGround(xx, yy)
	//		return true
	//}
	
	#endregion
	
	#region Player-specific stuff
	
	if place_meeting_flag(_x, _y, SOLID) {
		return true
	}
	
	// Dropdown and One way platforms
	if spd.y >= 0 {
		dropdown = position_meeting_flag(_x, bbox_bottom - y + _y + 1, DROPDOWN)
		oneway = position_meeting_flag(_x, bbox_bottom - y + _y + 1, ONEWAY)
		on_platform = oneway or (dropdown and !buffer.dropdown)
		
		if on_platform
			return true
	}
	
	#endregion
	}
	else {
	#region Only check corners
	
	return pointGround(left, top)
		|| pointGround(right, top)
		|| pointGround(left, bottom)
		|| pointGround(right, bottom)
	
	#endregion Much Faster, but very imprecise implementation
	}
	
	return false
}

pointDreamblock = function(_x, _y) {
	tilemap = layer_tilemap_get_id(layer_get_id("Dreamblock"))
	//return tile_get_index(tilemap_get_at_pixel(tilemap, _x, _y))
	return tilemap_get_at_pixel(tilemap, _x, _y)
}

meetingDreamblock = function(_x, _y) {
	left	= floor	(bbx_l - pos.x + _x)
	right	= ceil	(bbx_r - pos.x + _x)
	top		= floor	(bbx_t - pos.y + _y)
	bottom	= ceil	(bbx_b - pos.y + _y)
	
	return pointDreamblock(_x, _y)
		|| pointDreamblock(left, top)
		|| pointDreamblock(left, bottom)
		|| pointDreamblock(right, top)
		|| pointDreamblock(right, bottom)
	//return pointDreamblock(_x, _y)
}

///@function	collision()
///@description Corrects position to not collide with anything
collision = function() {
	#region Push yourself up if stuck in blocks
	//Normally this should never happen, but ya know
	
	//while(meetingGround(pos.x, pos.y))
		//pos.y--
	
	if meetingGround(pos.x, pos.y)
		show_dmsg(object_get_name(object_index)+"STUCK!")
	
	#endregion
	#region Get Stair height
	if variable_instance_exists(self, "state") {
		if state == Idle or state == Walk
			stair_height = 10
		else if state == Jump
			stair_height = 4
		else if state == Dash
			stair_height = 20
		else
			stair_height = 0
	}
	else {
		stair_height = 4
	}

	#endregion	
	#region Round the speed
	
	fraction.x = spd.x - (floor(abs(spd.x)) * sign(spd.x))
	fraction.y = spd.y - (floor(abs(spd.y)) * sign(spd.y))
	
	// We don't want to deal with decimal positions...
	spd.Subtract(fraction)

	#endregion
	#region !Collision checking!
	
	clip_width = 8	// Least width of the wall hitbox to avoid clipping
					// Less = more precision, more = better performance
	
	colliding = false
	staircase = false
	
	// Change the behaviour if inside a dream block
	__tile3 = object_index == oPlayer and meetingDreamblock(pos.x, pos.y)
	
	
	#region X collision
	#region Check for collision
	xcol = function() {
		xx = pos.x
		yy = pos.y
		repeat(abs(spd.x) div clip_width) {
			xx += clip_width * sign(spd.x)
			if meetingGround(xx, yy)
				return true
		}
		return meetingGround(pos.x + spd.x, pos.y)
	}()
	#endregion
	#region Prevent from colliding
	
	if xcol
	{
		#region Forgive some pixels to avoid frustration
		if !meetingGround(pos.x + spd.x, pos.y - stair_height)
		{
			//var check = stair_height
			check = 1
			for(; check <= stair_height; check++)
			{
				if !meetingGround(pos.x + spd.x, pos.y - check) {
					break
				}
			}
			
			pos.y -= check
			staircase = true // Useless
		}
		#endregion
		#region Stand exactly 1 pixel away from the wall
		else {
			while !meetingGround(pos.x + sign(spd.x), pos.y)
			{
				pos.x += sign(spd.x)
			}
			
			
			colliding = true
			
			
			if __tile3 and buffer.afterdash > 0
			{
				spd.x = -spd.x
				velo.x = -velo.x
				fraction.x = -fraction.x
				prev_spd.x = -prev_spd.x
			}
			else
			{
				spd.x = 0
				velo.x = 0
				fraction.x = 0
			}
		}
		#endregion
	}
	pos.x += spd.x

	#endregion
	
	#endregion
	#region Y collision
	#region Check for collision
	
	//tile3 = object_index == oPlayer and meetingDreamblock(pos.x, pos.y)
	
	ycol = function() {
		xx = pos.x
		yy = pos.y
		repeat(abs(spd.y) div clip_width) {
			yy += clip_width * sign(spd.y)
			if meetingGround(xx, yy)
				return true
		}
		// Dropdown
		
		return meetingGround(pos.x, pos.y + spd.y)
	}()
	
	#endregion
	#region Prevent from colliding
	
	if ycol
	{
		while !meetingGround(pos.x, pos.y + sign(spd.y))
		{
			pos.y += sign(spd.y)
		}
		
		colliding = true
		if __tile3 and buffer.afterdash > 0
		{
			spd.y = -spd.y
			velo.y = -velo.y
			fraction.y = -fraction.y
			prev_spd.y = -prev_spd.y
		}
		else
		{
			spd.y = 0
			velo.y = 0
			fraction.y = 0
		}
	}
	pos.y += spd.y
	
	#endregion

	#endregion
	
	
	if colliding
		onCollision()
	
	#endregion
	#region Round the speed back
	// ...but we want to save decimal velocity between frames
	spd.Add(fraction)
	
	#endregion
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