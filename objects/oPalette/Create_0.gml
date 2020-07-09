/// @desc
palette_spr = sPalette
palette = 0
max_palette = sprite_get_width(sPalette) - 1

palettes = new Array(0)

//alarm[0] = 60

save = function() {
	var map = ds_map_create()
	
	for(var i = 0; i < palettes.Size; i++) {
		map[? palettes.Get(i)] = 1
	}
	
	ds_map_secure_save(map, "palettes.txt")
	ds_map_destroy(map)
}

load = function() {
	if file_exists("palettes.txt")
	{
		var map = ds_map_secure_load("palettes.txt")
		for(var k = ds_map_find_first(map); !is_undefined(k); k = ds_map_find_next(map, k)) {
			palettes.Append(k)
		}
	
		ds_map_destroy(map)
	}
}


load()



increment = function() {
	palette++
	while (!palettes.Exists(palette))
	{
		palette++
		
		if palette > max_palette
			palette = 0
		
		if palettes.Empty()
			break
	}
}