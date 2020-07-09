_dependencies = [
	InputClass(),
	JSON(),
	Shortened()
]

global.modules = {
	input: global.Input,
	json: global.Json,
	_: global._
}

///@function	require(module)
///@param		{string} module
function require(module) {
	
	return variable_struct_get(global.modules, module)
}