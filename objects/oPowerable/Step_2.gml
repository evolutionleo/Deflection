/// @desc
if active {
	if variable_instance_exists(self, "onActive")
		onActive()
}
else {
	if variable_instance_exists(self, "onInactive")
		onInactive()	
}