/// @desc Movement setup

switch(movement_pattern) {
	case "Idle":
		target = self
		
		targetx = target.x
		targety = target.y
		
		break
	case "Path":
		try {
			my_path = global.Paths.Get(path_id)
		}
		catch(err) {
			exit
		}
		
		target_pos = path_pos + path_dir
		
		if(target_pos < 0 or target_pos > my_path.Size-1) {
			switch(path_action) {
				case "Restart":
					path_pos = 0
					break
				case "Reverse":
					path_dir *= -1
					break
				case "Stop":
					path_dir = 0
					break
				case "Loop":
					target_pos = 0
					break
			}
		}
		
		try {
			target = my_path.Get(target_pos)
		}
		catch(err) {
			target_pos = path_pos + path_dir
			target = my_path.Get(target_pos)
		}
		
		targetx = target.x
		targety = target.y
		
		
		// Endaction
		if(distance_to_point(targetx, targety) < sprite_width/2)
			path_pos += path_dir
		
		
		break
	case "NearestPlayer":
		target = instance_nearest(pos.x, pos.y, oPlayer)
		
		targetx = target.x
		targety = target.y
		
		break
	case "HorizontalCycle":
		nextX = pos.x+spd.x
		nextY = pos.y+spd.y
		sw = abs(sprite_width)*sign(spd.x)/2
		
		offCliff = !meetingGround(nextX + sw, nextY + 1)
		
		if(move.x == 0) {
			move.x = 1
		}
		else if(meetingGround(nextX+move.x, pos.y) or !flying and offCliff) {
			move.x *= -1
			spd.x = 0
		}
		
		targetx = pos.x+move.x
		targety = pos.y
		
		break
	case "VarticalCycle":
		sh = abs(sprite_height) * sign(spd.y)/2
		nextX = pos.x+spd.x
		nextY = pos.y+spd.y
		
		offWall = (!meetingGround(nextX+1, nextY+sh) or !meetingGround(nextX-1, nextY+sh))
		
		if(move.y == 0) {
			move.y = 1
		}
		else if(meetingGround(pos.x, nextY+move.y) or !flying and offWall) {
			move.y *= -1
			spd.y = 0
		}
		targetx = pos.x
		targety = pos.y+move.y
		
		break
	case "TargetObject":
		targetx = target.x
		targety = target.y
		
		break
}


if(movement_pattern != "HorizontalCycle" and movement_pattern != "VerticalCycle") {
	_dir = point_direction(pos.x, pos.y, targetx, targety)
	xdir = lengthdir_x(1, _dir)
	ydir = lengthdir_y(1, _dir)
	
	move = new Vector2(xdir, ydir)
}