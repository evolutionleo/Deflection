/// @desc

callstack.Lambda(function(call, pos) {
	if call.time <= 0
	{
		//show_debug_message("calling: "+string(call))
		with(call.inst)
		{
			call.func(call.props)
		}
		
		if (call.props.cycle)
		{
			call.time = call.max_time
		}
	}
	
	call.time--
	
	return call
})



callstack = callstack.Filter(function(call) {
	
	if (call.time <= 0 and !call.props.cycle)
		return 0
	else
		return 1
})