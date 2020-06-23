_dependencies = [
	SetTimeout(),
	ArrayClass()
]

global.Input = new function() constructor{
	binds = {
		right: [ord("D"), vk_right],
		left: [ord("A"), vk_left],
		down: [ord("S"), vk_down],
		up: [ord("W"), vk_up],
		jump: [vk_space, vk_up],
		restart: [ord("R")],
		quit: [vk_escape]
	}
	get = function(input) {
		var bind = variable_struct_get(self.binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button(-bind[i])
				return 1
			else if keyboard_check(bind[i])
				return 1
		}
		return 0
	}
	getRight = function() {return self.get("right")}
	getLeft = function() {return self.get("left")}
	getDown = function() {return self.get("down")}
	getUp = function() {return self.get("up")}
	
	getPressed = function(input) {
		var bind = variable_struct_get(self.binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_pressed(-bind[i])
				return 1
			else if keyboard_check_pressed(bind[i])
				return 1
		}
		return 0
	}
	
	getJump = function() {return self.getPressed("jump")}
	
	getReleased = function(input) {
		var bind = variable_struct_get(self.binds, input)
		for(var i = 0; i < array_length(bind); i++) {
			if bind[i] < 0 and mouse_check_button_released(-bind[i])
				return 1
			else if keyboard_check_released(bind[i])
				return 1
		}
		return 0
	}
	getAxis = function(axis) {
		if axis == "Horizontal" {
			return self.get("right") - self.get("left")
		}
		else if axis == "Vertical" {
			return self.get("down") - self.get("up")
		}
		else {
			throw "Error! Unknown axis passed to Input.getAxis()"
		}
	}
	getAny = function() {
		return keyboard_check(vk_anykey)
	}
	addBind = function(bind_name, value) { // Pass in negative value to set a mouse bind
		var bind = variable_struct_get(self.binds, bind_name)
		if is_undefined(bind)
			bind = []
		if !array_to_Array(bind).Exists(value) {
			bind[array_length(bind)] = value
		}
		variable_struct_set(self.binds, bind_name, bind)
	}
	clearBind = function(bind_name) {
		variable_struct_set(self.binds, bind_name, [])
	}
	getBind = function(bind_name) {
		return variable_struct_get(self.binds, bind_name)
	}
	
}()