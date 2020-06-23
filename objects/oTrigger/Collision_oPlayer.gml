/// @desc
with(oPowerable)
{
	if channel == other.channel
	{
		active = true
		
		if variable_instance_exists(self, "onActivation")
			onActivation()
	}
}