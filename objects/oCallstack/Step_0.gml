
todelete.Clear()

callstack.ForEach(function(_call, _pos) {
	try {
	//var inst, func, time, props
	call = _call
	pos = _pos
	
	inst = call._inst
	func = call._func
	time = call._time
	props = call._props
	
	if (time <= 0)
	{
		if inst == noone
			inst = id
		
		with(inst) { other.func(other.props) }
		
		if !call._props.cycle
			todelete.Append(call._id)
		else
			call._time = call._max_time
	}
	
	call._time -= 1
	
	callstack.Set(pos, call)
	} catch(e) {}
})

callstack = callstack.Filter(function(call) {
	try {
		
	if todelete.Exists(call._id)
		return 0
	else
		return 1
	} catch(e) { }
})