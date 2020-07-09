///@desc Third bullet

rot = pdir(x, y, oPlayer.x, oPlayer.y)

var bul = instance_create_layer(x, y, "Bullets", oBullet)
bul.owner = self
bul.ghost = true
bul.setDirection(rot)
	
with(bul) {
	img_xs = 3
	img_ys = 3
	sp = 9
}