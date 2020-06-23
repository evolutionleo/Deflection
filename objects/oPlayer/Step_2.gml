/// @desc State transition

switch(state) {
	case Idle:
		spr = sPlayerIdle
		
		if move.x != 0
			state = Walk
		
		break
	case Walk:
		spr = sPlayerWalk
		
		if move.x == 0
			state = Idle
		break
	case Jump:
		spr = sPlayerJump
		
		if onGround()
			state = move.x == 0 ? Idle : Walk
		
		break
	case Dead:
		spr = sPlayerDead
		
		break
}


if sprite_index != spr
	sprite_index = spr


if move.x != 0
	image_xscale = abs(image_xscale) * move.x