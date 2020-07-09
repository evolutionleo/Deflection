/// @desc
onActivation = function() {
	active = active xor active
}
//onDeactivation = function() { }
onActive = function() { 
	if image_index == 0
		image_speed = 1
}
onInactive = function() {
	image_index = 0
	image_speed = 0
}

//listenChannel(self, channel, function(pow) {
//	active = sign(pow)
//})

event_inherited()

instance_add_flag(id, SOLID)