_dependencies = [
	MapClass()
]


///@function call_inst(func, inst, delay, props)
///@param	{function} func
///@param	{real} inst
///@param	{int} delay
///@param	{struct} props
function call_inst(_func, _inst, _delay, _props) {
	
	if !instance_exists(oCallstack)
		instance_create_depth(0, 0, 0, oCallstack)
	
	props = {
		pers: false,
		cycle: false
	}
	
	props = new Map(props)
	_props = new Map(_props)
	
	_props.ForEach(function(prop, name) {
		other.props.Set(name, prop)
	})
	
	delete _props
	
	props = props.content
	
	
	var _object = {inst: _inst, func: _func, time: _delay, max_time: _delay, props: props}
	oCallstack.callstack.PushBack(_object)
	
	return _object
}

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
///@param		{real} inst
///@param		{func} function
///@param		{real} delay
///@param		{struct} *props
function setTimeout(inst, func, delay) {
	//var inst = instance_create_depth(0, 0, 0, oDelay)
	//inst.delay = delay
	//inst.execute = func
	
	if(argument_count > 3) {
		var props = argument[3]
	}
	else props = {}
	
	inst = other
	
	//return inst
	return call_inst(func, inst, delay, props)
}

///@function	setInterval(func, delay)
///@description Repeatedly calls a function after n frames. Call/Pass in stopInterval() to interrupt
///@note		Due to the way scoping and function binding works in GML,
///				you can only use instance variables inside the callback function.
///				Props ( default = {} ) are passed into function, so you can use props.%name% inside it
///				Also props struct is used to store meta data (Full list found at the bottom of this script)
///@example		_id = setInterval(function(props) { 
///					show_debug_message(props.str)
///					x += 128
///				}, 120, {val: y, str: "abc"}, false)
///@param		{real} inst
///@param		{func} function
///@param		{real} delay
///@param		{struct} *props
function setInterval(inst, func, delay) {
	//var inst = instance_create_depth(0, 0, 0, oDelay)
	//inst.delay = delay
	//inst.execute = func
	//inst.repeatable = true
	
	if(argument_count > 3) {
		var props = argument[3]
	}
	else props = {}
	
	
	props.cycle = true

	//return inst
	
	inst = other
	call_inst(func, inst, delay, props)
}

///@function	stopTimeout(*id)
///@description Deletes a timeout object, returned by setTimeout() function
///@param		{real} *id
function stopTimeout() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	//instance_destroy(_id)
}

///@function	stopInterval(*id)
///@description Deletes a cycle object, returned by setInterval() function
///@param		{real} *id
function stopInterval() {
	if argument_count > 0
		var _id = argument[0]
	else
		_id = self
	
	//instance_destroy(_id)
}



// All meta variables:
// don't use these variable names in props struct if you don't want to break anything

// pers		- =persistent. Set it to true if you don't want your function to be terminated on room change
// cycle	- read-only. Is equal to true if function was called from setInterval() and false if from setTimeout()
// 