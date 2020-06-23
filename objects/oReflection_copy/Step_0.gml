/// @desc
var bul = instance_place(x, y, oBullet)

if (bul and bul.owner != oReflection and bul.owner != self ) {
	if !variable_instance_exists(bul, "damage")
		bul.damage = image_xscale/2
	
	with(oReflection) {
		hit(bul.damage*4)
	}
	self.hit(bul.damage)
	instance_destroy(bul)
}