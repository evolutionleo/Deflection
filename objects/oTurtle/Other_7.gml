/// @desc
switch(state) {
	case AttackStart:
		state = Attack
		break
	case Attack:
		state = AttackEnd
		
		// Shoot
		var count = irandom_range(3, 5)
		//var count = 1
		repeat(count)
		{
			var dir = random_range(45, 135)
			var impulse = 8
			var rad = 2
			
			var xsp = lengthdir_x(impulse, dir)
			var ysp = lengthdir_y(impulse, dir)
			
			var vec = new Vector2(xsp, ysp)
			
			var xx = x + lengthdir_x(rad, dir)
			var yy = y + lengthdir_y(rad, dir)
			
			var inst = instance_create_layer(xx, yy, "Bullets", oFlyingSpike)
			
			var __WTF__ = inst.setSpeed(vec)
			inst.owner = id
		}
		break
	case AttackEnd:
		state = Walk
		alarm[1] = cooldown
		break
}