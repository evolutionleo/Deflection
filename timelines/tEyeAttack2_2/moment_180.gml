///@desc Fourth wave

var rot = 15
var delta_rot = 30
while(rot <= 360) {
	var bul = instance_create_layer(x, y, "Bullets", oBullet)
	bul.owner = self
	bul.ghost = true
	bul.setDirection(rot)
	
	with(bul) {
		img_xs = 3
		img_ys = 3
		sp = 6
	}
	
	rot += delta_rot
}
