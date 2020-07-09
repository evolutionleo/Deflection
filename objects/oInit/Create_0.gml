/// @desc
#macro TILE_SIZE 16

global.collision_map = new Array()

xtiles = sprite_get_width(sTiles) / TILE_SIZE
ytiles = sprite_get_height(sTiles) / TILE_SIZE


//global.solid_tiles = new Array(1, 2, 3, 4, 5, 6, 7, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19)
global.nonsolid_tiles = new Array(8, 10)



pal_swap_init_system(shd_pal_swapper)