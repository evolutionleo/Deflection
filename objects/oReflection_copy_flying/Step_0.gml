/// @desc
event_inherited()

var bul = instance_place(x, y, oBullet)

if (bul and bul.owner != oReflection and bul.owner != self) {
	if !variable_instance_exists(bul, "damage")
		bul.damage = image_xscale/2
	
	instance_destroy()
	with(oReflection)
	{
		//hit(bul.damage*4)
		hp = instance_number(oReflection_copy_flying)*max_hp*.4/6
		handleHealth()
	}
	//self.hit(bul.damage)
	instance_destroy(bul)
}


velo.Zero()


switch(state)
{
	case Chasing:
		applyVelocity(base_spd.Multiplied(move))
		
		break
	case Attack:
		spd.Multiply(toVector2(.9))
		break
	case Idle:
		spd.Multiply(toVector2(.95))
		break
}

show_debug_message("_______")
show_debug_message("Switching state...")
show_debug_message("Speed: "+string(spd))
show_debug_message("_______")