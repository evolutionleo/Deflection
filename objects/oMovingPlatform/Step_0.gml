/// @desc

#region Activate

if distance_to_object(oPlayer) < 2 and state == Inactive
{
	state = Forward
}

#endregion
#region Simple State Machine

if state == Forward
{
	path_pos = 0
	path_dir = 1
	spd = new Vector2(sp, sp)
}
elif state == Backwards
{
	path_pos = 1
	path_dir = -1
	spd = new Vector2(back_sp, back_sp)
}
else
{
	path_pos = 0
	path_dir = 0
	spd = new Vector2(0, 0)
}

#endregion only 3 states :)
#region Get direction based on 2-points path

np = cpath_get_point(path_id, path_pos + path_dir) // np = next_point


_dir = pdir(x, y, np.x, np.y)
dir.x = lengthdir_x(1, _dir)
dir.y = lengthdir_y(1, _dir)


spd.Multiply(dir) // Only works with constant speed (velocity will break it)

#endregion

// Round the speed
spd.Function(function(_x) { return round(_x) } )

#region Define on which side is player standing

playerDir = undefined

if distance_to_object(oPlayer) <= 10
{
	playerDir = 720
	
	if (oPlayer.bbox_bottom > bbox_top // Not above and not below
	and oPlayer.bbox_top < bbox_bottom)
	{
		if (oPlayer.bbox_left > bbox_right) // To the right
		{
			playerDir = RIGHT
		}
		else if (oPlayer.bbox_right < bbox_left + 1) // To the left
		{
			playerDir = LEFT
		}
	}
	else if (oPlayer.bbox_right > bbox_left // Not to the right and not to the left
	and oPlayer.bbox_left < bbox_right)     // basically not diagonal
	{
		if (oPlayer.bbox_top > bbox_bottom) // Below
		{
			playerDir = DOWN
		}
		else if (oPlayer.bbox_bottom < bbox_top + 1) // Above
		{
			playerDir = UP
		}
	}
}

#endregion
#region Pushing player 1

// Get player's offset to move him later
// (get before applying speed!)

xoff = oPlayer.x - pos.x
yoff = oPlayer.y - pos.y

#endregion

// pos.Add(spd)

pos.x += spd.x
pos.y += spd.y

x = pos.x
y = pos.y

#region Pushing player 2 (super 5Head)

if (place_meeting(x, y, oPlayer))
	show_dmsg("FUCC!")

switch(playerDir)
{
	case RIGHT:
		while (place_meeting(x, y, oPlayer)) {
			oPlayer.x++
		}
		
		if place_meeting(x+5, y, oPlayer) {
			while(!place_meeting(x+1, y, oPlayer)) {
				oPlayer.x--
			}
		}
		
		oPlayer.y = pos.y + yoff
		
		break
	case LEFT:
		while (place_meeting(x, y, oPlayer)) {
			oPlayer.x--
			show_dmsg("Moved player")
		}
		
		if place_meeting(x-5, y, oPlayer) {
			while(!place_meeting(x-1, y, oPlayer)) {
				oPlayer.x++
			}
		}
		
		oPlayer.y = pos.y + yoff
		
		break
	case DOWN:
		while (place_meeting(x, y, oPlayer)) {
			oPlayer.y++
		}
		
		//while(!place_meeting(x, y+1, oPlayer)) {
		//	oPlayer.y++
		//}
		//oPlayer.x = pos.x + xoff
		
		break
	case UP:
		while (place_meeting(x, y, oPlayer)) {
			oPlayer.y--
		}
		
		if place_meeting(x, y-5, oPlayer) {
			while(!place_meeting(x, y-1, oPlayer)) {
				oPlayer.y++
			}
		}
		
		oPlayer.x = pos.x + xoff
		
		break
	case 720:
		while (place_meeting(x, y, oPlayer)) {
			oPlayer.x += sign(spd.x)
			oPlayer.y += sign(spd.y)
		}
		break
}

oPlayer.pos.x = oPlayer.x
oPlayer.pos.y = oPlayer.y

#endregion
#region Deactivation

if distance_to_point(np.x, np.y) < 4 {
	if state == Forward
		state = Backwards
	else if state == Backwards
		state = Inactive
	
	momentum_delay = max_momentum_delay
	prev_spd = spd
}

momentum_delay--

if momentum_delay <= 0
	prev_spd.Zero()

#endregion