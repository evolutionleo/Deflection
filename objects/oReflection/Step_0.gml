/// @desc

applySpeed(grv)

// Inherit the parent event
event_inherited();


if place_meeting(pos.x, pos.y, oPlayer) {
	oPlayer.hit()
}


var bul = instance_place(x, y, oBullet)

if (bul and bul.owner != oReflection and bul.owner != self) {
	if !variable_instance_exists(bul, "damage")
		bul.damage = .5
	
	with(oReflection) {
		hit(bul.damage)
	}
	self.hit(bul.damage)
	instance_destroy(bul)
}