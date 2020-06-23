///@function	setTimeout(func, delay, *)
///@description Calls a function after n frames. Use stopInterval() to interrupt
///@note		Due to the way scoping and function binding works in GML,
///				you can only use instance variables inside the callback function.
///				Props ( default = {} ) are passed into function, so you can use props.name inside
///@example		_id = setTimeout(function(props) { 
///					show_debug_message(props.str)
///					x += 128
///					show_debug_message(props.val)
///				}, 120, {val: y, str: "abc"}, false)
///@param		{func} function
///@param		{real} delay
///@param		{struct} *props
///@param		{bool} *persistent
function setTimeout(func, delay) {
	//show_message("Calling setTimeout() from "+string(other))
	//func = method(self, func)
	
	var inst = instance_create_depth(0, 0, 0, oDelay)
	inst.delay = delay
	inst.execute = func
	
	if(argument_count > 2) {
		var props = argument[2]
		inst.props = props
	}
	if(argument_count > 3) {
		var pers = argument[3]
		inst.persistent = pers
	}
	
	return inst
}


///@function	setInterval(func, delay)
///@description Repeatedly calls a function after n frames. Call/Pass in stopInterval() to interrupt
///@note		Due to the way scoping and function binding works in GML,
///				you can only use instance variables inside the callback function.
///				Props ( default = {} ) are passed into function, so you can use props.%name% inside it
///@example		_id = setInterval(function(props) { 
///					show_debug_message(props.str)
///					x += 128
///				}, 120, {val: y, str: "abc"}, false)
///@param		{func} function
///@param		{real} delay
///@param		{struct} *props
///@param		{bool} *persistent
function setInterval(func, delay) {
	var inst = instance_create_depth(0, 0, 0, oDelay)
	inst.delay = delay
	inst.execute = func
	inst.repeatable = true
	
	if(argument_count > 2) {
		var props = argument[2]
		inst.props = props
	}
	if(argument_count > 3) {
		var pers = argument[3]
		inst.persistent = pers
	}
	
	return inst
}

///@function	stopTimeout(*id)
///@description Deletes a timeout object, returned by setTimeout() function
///@param		{real} *id
function stopTimeout() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	instance_destroy(_id)
}

///@function	stopInterval(*id)
///@description Deletes a cycle object, returned by setInterval() function
///@param		{real} *id
function stopInterval() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	instance_destroy(_id)
}