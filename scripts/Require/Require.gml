_dependencies = [
	InputClass()
]

global.modules = {
	input: global.Input,
	json: global.Json
}

///@function	require(module)
///@param		{string} module
function require(module) {
	
	return variable_struct_get(global.modules, module)
}