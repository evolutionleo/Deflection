/// @desc

switch(state) {
	case Activating:
		state = Active
		active_time = 0
		
		break
	case Deactivating:
		state = Inactive
		
		if parried
			cooldown /= 2
		
		break
}