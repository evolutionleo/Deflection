_dependencies = [
	SetTimeout(),
	ArrayClass()
]



global.Input = new function() constructor{
	gp = -4
	
	binds = { // Can be modified manually or using API
		right:	[ord("D"), vk_right,gp_padr+100],
		left:	[ord("A"), vk_left,	gp_padl+100],
		down:	[ord("S"), vk_down,	gp_padd+100],
		up:		[ord("W"), vk_up,	gp_padu+100],
		jump:	[vk_space, vk_up,	gp_face1+100],
		restart:[ord("R")],
		quit:	[vk_escape]
	}
	get = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button(-bind[i])
				return 1
			else if bind[i] > 100 and gamepad_button_check(gp, bind[i]-100)
				return 1
			else if keyboard_check(bind[i])
				return 1
		}
		return 0
	}
	getRight = function() {return get("right")}
	getLeft = function() {return get("left")}
	getDown = function() {return get("down")}
	getUp = function() {return get("up")}
	
	getPressed = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_pressed(bind[i]+100)
				return 1
			else if bind[i] > 100 and gamepad_button_check_pressed(gp, bind[i]-100)
				return 1
			else if keyboard_check_pressed(bind[i])
				return 1
		}
		return 0
	}
	
	getJump = function() {return getPressed("jump")}
	
	getReleased = function(input) {
		bind = variable_struct_get(binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_released(-bind[i])
				return 1
			else if bind[i] > 100 and gamepad_button_check_released(gp, bind[i]-100)
				return 1
			else if keyboard_check_released(bind[i])
				return 1
		}
		return 0
	}
	getAxis = function(axis) {
		if axis == "Horizontal" {
			__val = get("right") - get("left") + gamepad_axis_value(gp, gp_axislh)
			return clamp(__val, -1, 1)
		}
		else if axis == "Vertical" {
			__val = get("down") - get("up") + gamepad_axis_value(gp, gp_axislv)
			return clamp(__val, -1, 1)
		}
		else {
			throw "Error! Unknown axis passed to Input.getAxis(). Expected \"Horizontal\" or \"Vertical\""
		}
	}
	getAny = function() {
		return keyboard_check(vk_anykey) || mouse_check_button(mb_any) // gamepad is slightly more complicated
	}
	addBind = function(bind_name, value) {	// |bind|
											// +0 = keyboard
											// -100 = mouse
											// +100 = gamepad
		bind = variable_struct_get(binds, bind_name)
		if is_undefined(bind)
			bind = []
		if !array_to_Array(bind).Exists(value) {
			bind[array_length(bind)] = value
		}
		variable_struct_set(binds, bind_name, bind)
	}
	clearBind = function(bind_name) {
		variable_struct_set(binds, bind_name, [])
	}
	getBind = function(bind_name) {
		return variable_struct_get(binds, bind_name)
	}
	setGamepad = function(gamepad) {
		if is_undefined(gamepad)
		{
			for (var _gp = 0; _gp < 12; _gp++)
			{
				if gamepad_is_connected(_gp)
				{
					gp = _gp
					break
				}
			}
		}
		else gp = gamepad
	}
	getGamepad = function() { return gp }
	
}() // Yes, I just called a constructor. So what?


//global.Input.setGamepad()
global.Input.gp = 4
//show_message(global.Input.getGamepad())