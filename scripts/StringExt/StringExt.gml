function string_ext() {
	var __str = argument[0]
	
	for(var i = 1; i < argument_count; ++i) {
		__str = string_replace(__str, "%", string(argument[i]))
	}
	
	return __str
}

function se() {
	var __str = argument[0]
	
	for(var i = 1; i < argument_count; ++i) {
		__str = string_replace(__str, "%", string(argument[i]))
	}
	
	return __str
}