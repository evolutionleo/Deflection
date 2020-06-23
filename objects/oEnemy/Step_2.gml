/// @desc State transition

switch(state) {
	case Idle:
		state_name = "Idle"
		break
	case Walk:
		state_name = "Walk"
		break
	case AttackStart:
		state_name = "AttackStart"
		break
	case Attack:
		state_name = "Attack"
		break
	case AttackEnd:
		state_name = "Recovery"
		break
	case Chasing:
		state_name = "Chasing"
		break
}


spr = asset_get_index(sprite_get_name(object_get_sprite(object_index))+state_name)

if(sprite_exists(spr) and sprite_index != spr)
	sprite_index = spr
