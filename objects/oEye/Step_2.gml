/// @desc

#region Procedural animation

if fixed_position {
	position = position // LoL
}
else if state == Attack { // Eye pupil position
	position = attacks[phase-1][attack-1].pos
}
else {
	position = positions[? state]
}

if is_array(position) {

	_len = position[0]
	_dir = position[1]


	switch(_dir)
	{
		case "move_x":
			_dir = pdir(0, 0, move.x, 0)
			break
		case "player":
			_dir = pdir(pos.x, pos.y, oPlayer.x, oPlayer.y)
			break
		case "fixed":
			_dir = pdir(x, y, pupil_pos.x, pupil_pos.y)
	}


	target_pos.x = pos.x + lengthdir_x(_len, _dir)
	target_pos.y = pos.y + lengthdir_y(_len, _dir)


	pupil_pos.x = lerp(pupil_pos.x, target_pos.x, .8)
	pupil_pos.y = lerp(pupil_pos.y, target_pos.y, .8)
}


#endregion
#region Sprite

switch(state)
{
	case Idle:
		spr = ""
		break
	case Chasing:
		spr = "Chase"
		break
	case Attack:
		spr = "Attack" + string(phase) + string(attack)
		break
	case AttackStart:
		spr = "Prep" + string(phase) + string(attack)
		break
	case AttackEnd:
		spr = "Rec" + string(phase) + string(attack)
		break
}


//show_debug_message("sEye"+spr)
//show_debug_message(asset_get_index("sEye"+spr))

spr1 = asset_get_index("sEye" + spr)
spr2 = asset_get_index("sPupil" + spr)


if sprite_index != spr1
{
	sprite_index = spr1
	pupil_sprite = spr2
}
#endregion