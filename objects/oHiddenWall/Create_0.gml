/// @desc

tilemap = layer_tilemap_get_id(layer_get_id("HiddenWall"))

reveal = function() {
	for(var xx = bbox_left; xx <= bbox_right; xx ++) {
		for(var yy = bbox_top; yy <= bbox_bottom; yy ++) {
			tilemap_set_at_pixel(tilemap, 0, xx, yy)
		}
	}
}

if activation == "Power" {
	onActivation = function()
	{
		reveal()
		instance_destroy()
	}
}