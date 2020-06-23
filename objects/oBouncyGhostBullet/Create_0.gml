/// @desc

// Inherit the parent event
event_inherited();

max_bounces = bounces
bounces = 0

onCollision = function() {
	if bounces < max_bounces {
		bounces++
		move.Function(function(x) { return -x})
	}
	else { instance_destroy() }
}
