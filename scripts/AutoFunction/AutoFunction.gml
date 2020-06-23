_dependencies = [
	SetTimeout()
]

#macro VAR_STRUCT 1
#macro VAR_INSTANCE 2
#macro VAR_GLOBAL 3
function autoset(type, inst, name, func) {
	#region Initial setting
	
	switch(type) {
		case VAR_STRUCT:
			variable_struct_set(inst, name, func())
			break
		case VAR_INSTANCE:
			variable_instance_set(inst, name, func())
			break
		case VAR_GLOBAL:
			variable_global_set(name, func())
			break
		default:
			throw "Invalid variable type"
			break
	}
	#endregion
	
	var props = {type: type, inst: inst, name: name, func: func}
	return setInterval(method(self, function(props) {
		#region Regular setting
		
		var type = props.type
		var inst = props.inst
		var name = props.name
		var func = props.func
		
		switch(type) {
			case VAR_STRUCT:
				variable_struct_set(inst, name, func())
				break
			case VAR_INSTANCE:
				variable_instance_set(inst, name, func())
				break
			case VAR_GLOBAL:
				variable_global_set(name, func())
				break
			default:
				throw "Invalid variable type"
				break
		}
		
		#endregion
	}), 1, props, {})
}

function autobreak(id) {
	stopInterval(id)
}