/// @desc State transition

switch(state) {
	case Idle:
		spr = sPlayerIdle
		
		if move.x != 0
			state = Walk
		
		if !onGround()
			state = Jump
		
		break
	case Walk:
		spr = sPlayerWalk
		
		if move.x == 0
			state = Idle
		
		if !onGround()
			state = Jump
		break
	case Jump:
		spr = sPlayerJump
		
		if onGround()
			state = move.x == 0 ? Idle : Walk
		else if nextToWall() != 0
			state = WallSlide
		#region Shield Slide
		else if kslide and my_shield and upgrades.Exists("Shield Slide") {
			if state != ShieldSlide {
				state = ShieldSlide
				my_shield.state = SlideStart
			}
			else {
				state = Jump
				my_shield.state = Inactive
				my_shield.active_time = 0
			}
		}
		#endregion
		break
	case Dash:
		spr = sPlayerDash
		
		repeat(10) {
			var xx = random_range(bbox_left, bbox_right)
			var yy = random_range(bbox_top, bbox_bottom)
			var part = instance_create_layer(xx, yy, "Effects", oDashParticle)
			part.direction = dash_dir
		}
		
		//Dash emitter positions. Bursting Particles.
		//var xp, yp;
		//xp = bbox_right;
		//yp = y;
		//part_type_direction(global.pt_dash, dash_dir, dash_dir, 0, 0);
		//part_emitter_region(global.ps, global.pe_dash, xp-16, xp+16, yp-16, yp+16, ps_shape_rectangle, ps_distr_gaussian);
		//part_emitter_burst(global.ps, global.pe_dash, global.pt_dash, 20);
		
		dash_duration++
		
		buffer.iframes = dash_iframes
		buffer.afterdash = buffer._max.afterdash
		
		if dash_duration > max_dash_duration {
			if onGround()
				state = Idle
			else
				state = Jump
			//buffer.dash = buffer._max.dash
		}
		#region Shield Slide
		else if kslide and my_shield and upgrades.Exists("Shield Slide") {
			if state != ShieldSlide {
				state = ShieldSlide
				my_shield.state = SlideStart
			}
			else {
				state = Jump
				my_shield.state = Inactive
				my_shield.active_time = 0
			}
		}
		#endregion
		break
	case WallSlide:
		spr = sPlayerWallSlide
		
		if nextToWall() == 0
			state = Jump
		else if onGround()
			state = Idle
		break
	case ShieldSlide:
		spr = sPlayerShieldSlide
		
		break
	case Dead:
		spr = sPlayerDead
		
		break
}


if sprite_index != spr
	sprite_index = spr

side = state == WallSlide
	? -nextToWall()
	: move.x
if side != 0
	image_xscale = abs(image_xscale) * side