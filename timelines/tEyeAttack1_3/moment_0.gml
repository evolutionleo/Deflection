///@desc First wave

var rot = pdir(x, y, oPlayer.x, oPlayer.y)
var target_rot = rot + 60
rot -= 60

var delta_rot = 10

while(rot <= target_rot) {
	var bul = instance_create_layer(x, y, "Bullets", oBullet)
	bul.owner = self
	bul.ghost = true
	bul.setDirection(rot)
	
	with(bul) {
		img_xs = 3
		img_ys = 3
		sp = 7
	}
	
	rot += delta_rot
}
