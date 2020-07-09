/// @desc
var xx = x
var yy = y

var _delta = sprite_get_height(sLaser1)

var dist = pdist(xx, yy, pointer.x, pointer.y)
var _xs = 1
var _ys = dist / _delta

//show_debug_message(active)

if active {
	draw_sprite_ext(sLaser1, 0, xx, yy, _xs, _ys, dir+90, c_white, 1.0)
}

img_xs = _xs
img_ys = _ys
img_ang = dir + 90
//xx = 

//draw_sprite_ext()