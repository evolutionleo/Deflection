/// @desc
//draw_sprite(hTiles, 0, 0, 0)

#region //Tile collision mask
//for(var ytile = 0; ytile < ytiles; ytile++)
//{
//	for(var xtile = 0; xtile < xtiles; xtile++)
//	{
//		// Create (binary) tile grid.
//		var this_tile = array_create(TILE_SIZE, array_create(TILE_SIZE, 0))
//		var tile_id = ytile*TILE_SIZE+xtile
		
//		if !global.nonsolid_tiles.Exists(tile_id)
//		{
//			// Fill the data. White = 1 = solid
//			for(var xx = 0; xx < TILE_SIZE; xx++)
//			{
//			for(var yy = 0; yy < TILE_SIZE; yy++)
//			{	
//				var col = surface_getpixel(application_surface, xtile * TILE_SIZE + xx, ytile * TILE_SIZE + yy)
//				var bit = (col != c_black)
				
//				//if(xtile == 1) {
//				//	show_message("Getting pixel at: (x: "+string(xtile*TILE_SIZE + xx)+"; y: "+string(ytile*TILE_SIZE + yy)+")")
//				//	show_message("Got color: "+string(col))
//				//}
				
//				this_tile[xx][yy] = bit
//			}
//		}
//		}
		
//		global.collision_map.Append(this_tile)
//	}
//}
#endregion
#region Debug
//global.collision_map.ForEach(function(tile, pos) {
//	show_debug_message("_______ tile#"+string(pos)+" ________")
//	for(var xx = 0; xx < TILE_SIZE; xx++) {
//		show_debug_message(tile[xx])
//	}
//})
#endregion

//draw_clear(c_white)
room_goto_next()