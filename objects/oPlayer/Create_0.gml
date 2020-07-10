/// @desc
#region Physics setup

#region Basic setup
event_inherited()

//fraction = new Vector2(0, 0)
acc = new Vector2(.3, 0)

#endregion
#region Extended physics

potential_spd = new Vector2(0, 0)

max_xsp = 20
max_base_xsp = 6
max_base_ysp = 20

min_xsp = -max_xsp

max_ysp = 16
min_ysp = -100

max_spd = new Vector2(max_xsp, max_ysp)
min_spd = new Vector2(min_xsp, min_ysp)

jump_vec = new Vector2(1, -8.5)
add_jump_vec = new Vector2(0, 0)

walljump_vec = new Vector2(4.5, -8.5)

dash_spd = 12
dream_spd = 5
//dash_spd = 100

bounce_vec = new Vector2(0, -5.5)
hit_vec = new Vector2(2, -7.5)

fric = {
	ground: {
		stop: [.25, 0],
		move: [.02, 0],
		reverse: [.05, 0],
		dash: [.1, .1]
	},
	wall: {
		stop: [.05, .05],
		move: [.25, .25],
		reverse: [0, 0],
		dash: [.05, .05]
	},
	air: {
		stop: [.05, 0],
		move: [0, 0],
		reverse: [.03, 0],
		dash: [.02, .02]
	},
	shield: {
		stop: [.01, 0],
		move: [0, 0],
		reverse: [.01, 0]
	}
}
#endregion
#region Physics functions

onGround = function() {
	return (pointGround(bbox_left+1, bbox_bottom+1)
		|| pointGround(bbox_right-1, bbox_bottom+1)
		|| pointGround(pos.x, bbox_bottom+1)
		|| meetingGround(pos.x, pos.y+1))
	//return meetingGround(pos.x, pos.y+1)
}

nextToWall = function() {
	if meetingGround(pos.x+2, pos.y)
		return 1
	else if meetingGround(pos.x-2, pos.y)
		return -1
	else
		return 0
}

jump = function() {
	if spd.y < 0
		spd.y = 0
	else
		spd.y = 0
	
	if argument_count == 0
		applySpeed(jump_vec.Multiplied(new Vector2(move.x, 1)))
	else
		applySpeed(argument0)
	
	
	#region Gain momentum
	
	potential_spd.Zero()
	
	with(oMovingPlatform) {
		if distance_to_object(other) <= 2 {
			//if spd == 0
				other.potential_spd.Add(prev_spd)
			//else
				other.potential_spd.Add(spd)
		}
	}
	
	spd.Add(potential_spd)
	potential_spd.Zero()
	
	#endregion
	
	state = Jump
	
	buffer.ground = 0
	buffer.jump = 0
}

dash = function() {
	if dashes < max_dashes
	{
		dash_dir = point_direction(x, y, mouse_x, mouse_y)
		state = Dash
		dash_duration = 0
	
		dash_vec = new Vector2(0, 0)
		dash_vec.x = lengthdir_x(dash_spd, dash_dir) // Clear code
		dash_vec.y = lengthdir_y(dash_spd, dash_dir)
		
		//spd.Multiply(toVector2(.5))
		
		setSpeed(dash_vec)
		
		dashes++
	}
}

airJump = function() {
	if air_jumps < max_air_jumps {
		jump()
		air_jumps ++
	}
}

walljump = function(side) {
	var vec = walljump_vec.Multiplied(new Vector2(-side, 1))
	//var vec = walljump_vec.Multiplied(new Vector2(-move.x, 1))
	jump(vec)
}

#endregion

#endregion
#region Buffering stuff

dash_duration = 0
max_dash_duration = 10
dash_dir = 0

buffer = {
	_max: {
		ground: 7,
		jump: 10,
		iframes: 60,
		dash: 3,
		midair: 3,
		shadow: 5,
		dropdown: 10,
		save: 10,
		afterdash: 15
	},
	ground: 0,
	jump: 0,
	iframes: 0,
	dash: 0,
	midair: 0,
	shadow: 0,
	dropdown: 0,
	save: 10,
	afterdash: 0
}

#endregion
#region State

#region State macros

#macro Dead -1
#macro Idle 0
#macro Walk 1
#macro Jump 2
#macro Dash 3
#macro WallSlide 4
#macro ShieldSlide 5

// Specific for enemies
#macro AttackStart 10
#macro Attack 11
#macro AttackEnd 12
#macro Chasing 13

#endregion

state = Idle

#endregion
#region Fighting

max_hp = 3
hp = 3

base_max_hp = max_hp

def = hb_add(id,"def", hPlayer)
atk = hb_add(id,"atk", hPlayer_feet)

blinking = false
dash_iframes = 15

func = function() {
	if !buffer.iframes or state == Dash
		blinking = false
	else
		blinking = !blinking
}

//setInterval(self, func, 15)

///@function is_invinsivle()
isInvincible = function() {
	return self.buffer.iframes
}

save = function() {
	//ini_open("upgrades.ini")
	//upgrades.ForEach(function(upgrade) {
	//	ini_write_real("Upgrades", upgrade, 1)
	//})
	//ini_close()
	//show_message(upgrades.ForEach)
	
	//if !upgrades.Empty() {
		map = ds_map_create()
		//upgrades.ForEach(function(upgrade) {
		//	show_debug_message(upgrade)
		//	global.map[? upgrade] = 1
		//})
		// Ah yes, S C O P E
		for(var i = 0; i < upgrades.Size; i++) {
			map[? upgrades.Get(i)] = 1
		}
		
		ds_map_secure_save(map, "upgrades.txt")
		ds_map_destroy(map)
		
		
		ini_open("coords.ini")
		ini_write_real("Position", "x", pos.x)
		ini_write_real("Room", "room", room)
		ini_write_real("Position", "y", pos.y)
		ini_write_string("Greetings", "Hello", "Dear Hacker")
		ini_close()
		
		
		create_text({x: pos.x, y: pos.y-48, font: fPixel, text: "Game Saved"})
	//}
}

load = function() {
	//if file_exists("upgrades.ini")
	//{
	//	ini_open("upgrades.ini")
	//	possibleUpgrades.ForEach(function(upgrade) {
	//		if ini_read_real("Upgrades", upgrade, false)
	//			upgrades.Append(upgrade)
	//	})
	//	ini_close()
	//}
	if file_exists("upgrades.txt") {
		var map = ds_map_secure_load("upgrades.txt")
		var struct = new Map(ds_map_to_struct(map))
		
		ds_map_destroy(map)	
		struct.ForEach(function(_, upgrade) {
			upgrades.Append(upgrade)
		})
	}
	
	ini_open("coords.ini")

	var rm = ini_read_real("Room", "room", room)
	if room == rm
	{
		pos.x = ini_read_real("Position", "x", pos.x)
		pos.y = ini_read_real("Position", "y", pos.y)
	}
	ini_close()
	
	
	_cam = instance_nearest(pos.x, pos.y, oCameraAnchor)
	with(oCameraAnchor) {
		active = false
	}
	_cam.active = true
	global.next_camera = _cam.cam_id
	
}

///@function setIframes(iframes)
///@param	 {int} iframes
setIframes = function(iframes) {
	self.buffer.iframes = iframes
}

die = function() {
	//create_freeze({time: 100})
	//room_goto(rGameover)
	//game_restart()
	room_restart()
}

handleHealth = function() {
	hp = clamp(hp, 0, max_hp)
	
	if hp = 0
	{
		die()
	}
}

hit = function() {
	if argument_count > 0
		var damage = argument[0]
	else
		damage = .5
	
	if argument_count > 1
		knock =argument[1]
	else
		var knock = new Vector2(0, -.5)
	
	if !isInvincible()
	{
		audio_play_sound_mute(aHit, 1.4, 0)
		
		self.hp -= damage
		spd.x = 0
		applySpeed(knock)
		jump(new Vector2(hit_vec.x*-move.x, hit_vec.y))
		
		handleHealth()
		setIframes(buffer._max.iframes)
		
		//create_freeze({time: 100})
		create_freeze({time: 50})
		create_flash({alpha: .5, fadespd: .02})
	}
}

#endregion
#region Metroidvania

#region Initial values

max_air_jumps = 0
air_jumps = 0	// this is mostly for optimization,
				// searching through array is slow
my_shield = noone

dashes = 0
max_dashes = 0	// this too

dash_jumps = 0	// and this

wall_jump = false // yep, and these even more
shield_slide = false
shield_jump = false
shield_bash = false
hyper_dash = false

#endregion
#region Upgrade structs

upgrades = new Array()
possibleUpgrades = new Array(
	"Double Jump",	//Additional jump in the air
	"Wall Jump",	//Ability to infinitely jump off walls.
					//possible to climb single walls
	
	"Shield",		//Ability to parry attacks
	"Shield Jump",	//Restore jump after blocking
	"Shield Slide",	//Slide on spikes/slopes
	"Shield Bash",	//Deal damage by 'shielding' enemies
	
	"Dash",			//Fast dash with iframes
	"Hyper Dash"	//Charged dash. Like regular dash but last longer
					//=> gives more distance
)
#endregion
#region Update function
updateUpgrades = function() {
	max_hp = base_max_hp
	
	upgrades.ForEach(function(upgrade)
	{
		switch(upgrade)
		{
			case "Double Jump":
				max_air_jumps = 1
				break
			case "Shield":
				if !instance_exists(oShield)
					my_shield = instance_create_layer(x, y, layer, oShield)
				break
			case "Wall Jump":
				wall_jump = true
				break
			case "Dash":
				max_dashes = 1
				break
			case "Shield Slide":
				shield_slide = true
				break
			case "Shield Jump":
				shield_jump = true
				break
			case "Shield Bash":
				shield_bash = true
				break
			case "Hyper Dash":
				hyper_dash = true
				break
			default:
				if string_pos("Health", upgrade) {
					max_hp++
					hp = max_hp
				}
				break
		}
	})
}

#endregion

load()

//if debug_mode {
	//upgrades.Append("Dash")
	//upgrades.Append("Shield")
	//upgrades.Append("Wall Jump")
	//upgrades.Append("Shield Jump")
	//upgrades.Append("Shield Slide")
//}

updateUpgrades()


#endregion
#region Inputs

Input = require("input")

Input.addBind("dash", mb_right-100)
Input.addBind("dash", gp_shoulderlb+100)

Input.addBind("jump", ord("W"))

Input.addBind("slide", vk_shift)
Input.addBind("slide", gp_shoulderrb+100)

#endregion
#region Particles

#region Dash particle

//Generated for GMS2 in Geon FX v1.3
//Put this code in Create event

//NewEffect Particle System
global.ps = part_system_create();
part_system_depth(global.ps, -1);

//DashEffect Particle Types
global.pt_dash = part_type_create();
part_type_shape(global.pt_dash, pt_shape_disk);
part_type_size(global.pt_dash, .2, .5, 0, 0);
part_type_scale(global.pt_dash, .5, .5);
part_type_orientation(global.pt_dash, 0, 0, 30, 0, 0);
part_type_color3(global.pt_dash, 16777215, 1771278, 1771278);
part_type_alpha3(global.pt_dash, 0.71, 0.51, 0);
part_type_blend(global.pt_dash, 0);
part_type_life(global.pt_dash, 25, 40);
part_type_speed(global.pt_dash, -10, -8, 0, 0);
part_type_gravity(global.pt_dash, 0, 0);

//Dash Emitters
global.pe_dash = part_emitter_create(global.ps);

#endregion

#endregion
#region Misc

time = 0

setInterval(noone, function() {
	global.freeze -= 10;
	global.freeze = clamp(global.freeze, 0, 1000)
}, 1)

_fps_real = fps_real
setInterval(self, function() {
	_fps_real = fps_real	
}, 30)

#endregion
