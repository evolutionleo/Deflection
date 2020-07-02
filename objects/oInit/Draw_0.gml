/// @desc
draw_sprite(sTiles, 0, 0, 0)

var xtiles = sprite_get_width(sTiles) / TILE_SIZE
var ytiles = sprite_get_height(sTiles) / TILE_SIZE

for(var xtile = 0; xtile < xtiles; xtile++)
{
	for(var ytile = 0; ytile < ytiles; ytile++)
	{
		var this_tile = array_create(TILE_SIZE, array_create(TILE_SIZE, 0))
		
		for(var xx = 0; xx < TILE_SIZE; xx++)
		{
			for(var yy = 0; yy < TILE_SIZE; yy++)
			{
				var col = draw_getpixel(xtile * TILE_SIZE + xx, ytile * TILE_SIZE + yy)
				var bit = (col != c_black)
				
				this_tile[xx][yy] = bit
			}
		}
		
		global.collision_map.Append(this_tile)
	}
}


global.collision_map.ForEach(function(tile) {
	show_debug_message("_______")
	for(var xx = 0; xx < TILE_SIZE; xx++) {
		show_debug_message(tile[xx])
	}
})

//room_goto_next()