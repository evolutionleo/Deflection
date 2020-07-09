/// @desc
onActivation = function() { }
onDeactivation = function() { }
onActive = function() { }
onInactive = function() { }

listenChannel(self, channel, function(pow) {
	switch(needed_power)
	{
		case "X":
			_active = pow == X
			break
		case "X Or More":
			_active = pow >= X
			break
		case "X Or Less":
			_active = pow <= X
			break
		case "Not X":
			_active = pow != X
			break
	}
	
	if active and !_active {
		onDeactivation()
	}
	else if !active and _active {
		onActivation()
	}
	
	active = _active
})