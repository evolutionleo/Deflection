///@function Map()
function Map() constructor {
	if argument_count > 0
		content = argument[0]
	else
		content = {}
	
	Set = function(key, val) {
		variable_struct_set(self.content, key, val)
		return self.content
	}
	
	Get = function(key) {
		return variable_struct_get(self.content, key)
	}
	
	///@function	GetNames()
	///@description	returns an array of names of all variables that're stored in map
	GetNames = function() {
		return variable_struct_get_names(self.content)
	}
	
	ForEach = function(func) {
		var names = variable_struct_get_names(self.content)
		for(var i = 0; i < array_length(names); i++) {
			var name = names[i]
			var value = variable_struct_get(self.content, name)
			
			func(value, name, i)
		}
	}
}


function struct_toMap(struct) {
	return new Map(struct)
}


///@function	ds_map_foreach(map, func)
///@description	Executes a function for each element of the map
///				Why not? Retyping the same thing is boring
///@param		{real} map
///@param		{function} func
function ds_map_foreach(map, func) {
	for(var k = ds_map_find_first(map); !is_undefined(k); k = ds_map_find_next(map, k)) {
		func(map[? k], k)
	}
}