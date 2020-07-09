/// @desc
event_inherited()

pointer = new Vector2(x, y)
dir = 0
delta = 5

active = false

fire = function() {
	active = true
	
	pointer = new Vector2(x, y)
	
	var dx = lengthdir_x(delta, dir)
	var dy = lengthdir_y(delta, dir)
	
	var d = new Vector2(dx, dy)
	
	while !pointGround(pointer.x, pointer.y)
	{
		if ( pointer.x < 0
		  || pointer.y < 0
		  || pointer.x > room_width
		  || pointer.y > room_height )
			break
		
		pointer.Add(d)
	}
}

shut = function() {
	active = false
	instance_destroy(atk)
	instance_destroy()
	//hb_destroy("atk")
}


atk = hb_add(id,"atk", hLaser)