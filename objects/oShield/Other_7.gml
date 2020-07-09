/// @desc [De]Activation

switch(state)
{
	case Activating:
		state = Active
		active_time = max_active_time
		cooldown = max_cooldown
		
		break
	case Deactivating:
		state = Inactive
		
		if parried
			cooldown /= 2
		
		break
}