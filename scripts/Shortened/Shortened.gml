_dependencies = [
	SetTimeout()
]


function show_dmsg(msg) {
	return show_debug_message(msg)
}

function show_msg(msg) {
	return show_message(msg)
}

function inst_create(x, y, lay, obj) {
	return instance_create_layer(x, y, lay, obj)
}

function inst_destroy(inst) {
	return instance_destroy(inst)
}

function inst_exists(obj) {
	return instance_exists(obj)
}

function inst_num(obj) {
	return instance_number(obj)
}

function tostr(val) {
	return string(val)
}

function pdir(x1, y1, x2, y2) {
	return point_direction(x1, y1, x2, y2)
}

function pdist(x1, y1, x2, y2) {
	return point_distance(x1, y1, x2, y2)
}

#macro spr_idx sprite_index
#macro obj_idx object_index
#macro img_idx image_index
#macro img_ang image_angle
#macro img_alp image_alpha
#macro img_xs image_xscale
#macro img_ys image_yscale

#macro bbx_l bbox_left
#macro bbx_r bbox_right
#macro bbx_t bbox_top
#macro bbx_b bbox_bottom

#macro bbox_center (bbx_l + bbx_r) / 2
#macro bbox_middle (bbx_t + bbx_b) / 2

#macro bbx_c bbox_center
#macro bbx_m bbox_middle

#macro mx mouse_x
#macro my mouse_y

#macro elif else if


#macro RIGHT 0
#macro UP 90
#macro LEFT 180
#macro DOWN 270



global._ = function() constructor {
	//mx = mouse_x
	//my = mouse_y
}()

//setInterval(noone, function() {
//	global._.mx = mouse_x
//	global._.my = mouse_y
//}, 1)