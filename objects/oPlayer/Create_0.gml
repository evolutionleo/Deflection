/// @desc
#region Physics setup

#region Basic setup
event_inherited()

//fraction = new Vector2(0, 0)
acc = new Vector2(.3, 0)

#endregion
#region Extended physics
max_xsp = 20
max_base_xsp = 6

min_xsp = -max_xsp

max_ysp = 16
min_ysp = -100

max_spd = new Vector2(max_xsp, max_ysp)
min_spd = new Vector2(min_xsp, min_ysp)

jump_vec = new Vector2(1, -8)
add_jump_vec = new Vector2(0, 0)

bounce_vec = new Vector2(0, -5)
hit_vec = new Vector2(2, -7)

max_air_jumps = 0
air_jumps = 0

fric = {
	ground: {
		stop: .25,
		move: .02,
		reverse: .25
	},
	air: {
		stop: .05,
		move: 0,
		reverse: 1
	}
}
#endregion
#region Physics functions

onGround = function() {
	return meetingGround(pos.x, pos.y+1)
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
	
	state = Jump
	
	buffer.ground = 0
	buffer.jump = 0
}


airJump = function() {
	if air_jumps < max_air_jumps {
		jump()
		air_jumps ++
	}
}
#endregion

#endregion
#region Buffering stuff
buffer = {
	_max: {
		ground: 7,
		jump: 10,
		iframes: 45
	},
	ground: 0,
	jump: 0,
	iframes: 0
}
#endregion
#region State

#region State macros

#macro Dead -1
#macro Idle 0
#macro Walk 1
#macro Jump 2
#macro Dash 3

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


blinking = false
func = function() {
	blinking = buffer.iframes ? !blinking : false
}

//////setInterval(self, func, 15)

///@function is_invinsivle()
isInvincible = function() {
	return self.buffer.iframes
}

save = function() {
	ini_open("upgrades.ini")
	//ini_write_string("Upgrades", "upgrades", string(upgrades))
	ini_write_real("Upgrades", "Double Jump", upgrades.Exists("Double Jump"))
	ini_write_real("Upgrades", "Shield", upgrades.Exists("Shield"))
	ini_close()
}

load = function() {
	if file_exists("upgrades.ini") {
		//Json = require("json")
		
		ini_open("upgrades.ini")
		//var json = ini_read_string("Upgrades", "upgrades", "[]")
		if(ini_read_real("Upgrades", "Double Jump", 0)) {
			upgrades.Append("Double Jump")
		}
		if(ini_read_real("Upgrades", "Shield", 0)) {
			upgrades.Append("Shield")
		}
		ini_close()
		
		//upgrades = Json.parse(json)
		//show_message(upgrades)
	}
}

///@function setIframes(iframes)
///@param	 {int} iframes
setIframes = function(iframes) {
	self.buffer.iframes = iframes
}

handleHealth = function() {
	hp = clamp(hp, 0, max_hp)
	
	if hp = 0
	{
		create_freeze({time: 300})
		//room_restart()
		//game_restart()
		//load()
		room_goto(rGameover)
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
		audio_play_sound(aHit, 1.4, 0)
		
		self.hp -= damage
		spd.x = 0
		applySpeed(knock)
		jump(new Vector2(hit_vec.x*-move.x, hit_vec.y))
		
		handleHealth()
		setIframes(buffer._max.iframes)
		
		create_freeze({time: 100})
		create_flash({alpha: .5, fadespd: .02})
	}
}

#endregion
#region Metroidvania

upgrades = new Array()

updateUpgrades = function() {
	upgrades.ForEach(function(upgrade) {
		switch(upgrade) {
			case "Double Jump":
				max_air_jumps = 1
				break
			case "Shield":
				if !instance_exists(oShield)
					my_shield = instance_create_layer(x, y, layer, oShield)
				break
		}
	})
}


load()
updateUpgrades()

#endregion

time = 0
Input = require("input")
Input.addBind("dash", -mb_right)
Input.addBind("jump", ord("W"))


def = hb_add("def", hPlayer)
atk = hb_add("atk", hPlayer_feet)


updateUpgrades()