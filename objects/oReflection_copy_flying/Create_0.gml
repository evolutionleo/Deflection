/// @desc
event_inherited()

hit = function(damage) {
	instance_destroy()
}


Shoot = function() {
	var gun = instance_create_layer(x, y,"Bullets", oBullet_spawner)
	with(gun) {
		props = {image_xscale: 1.5, image_yscale: 1.5, owner: oReflection}
		bullet_type = oGhostBullet
		lock_on = true
		active = true
		rate = 10
		stuck = other
		stopInterval(int)
		int = setInterval(shoot, rate, {})
		setTimeout(method(self, function() { instance_destroy() }), 50, {bind: gun})
	}
}

setState = method(self, function(st) {
	show_debug_message("______")
	show_debug_message("setState: "+string(st))
	switch(st) {
		case Idle:
			timeout = setTimeout(method(self, function() {
				if instance_exists(self)
					setState(Chasing)
			}), 120, {})
			break
		case Chasing:
			timeout = setTimeout(method(self, function() {
				if instance_exists(self)
					setState(Attack)
			}), 120, {})
			break
		case Attack:
			Shoot()
			timeout = setTimeout(method(self, function() { 
				if instance_exists(self)
					setState(Idle)
			}), 30, {})
			break
	}
	
	state = st
	
	show_debug_message("setState: "+string(state))
	show_debug_message("_________")
})



setState(Chasing)