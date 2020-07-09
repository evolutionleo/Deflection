/// @description pal_swap_draw_palette(palette_sprite,pal_index,x,y);
/// @function pal_swap_draw_palette
/// @param palette_sprite
/// @param pal_index
/// @param x
/// @param y
function pal_swap_draw_palette() {
	//Draws only the specified palette from the given palette sprite.
	draw_sprite_part(argument[0],0,argument[1],0,1,sprite_get_height(argument[0]),argument[2],argument[3]);
}

/// @description pal_swap_get_color_count(palette sprite)
#region pal_swap_get_color_count()

/// @function pal_swap_get_color_count
/// @param pal_sprite
function pal_swap_get_color_count() {
	return(sprite_get_height(argument[0]));
}
#endregion

#region pla_swap_get_pal_count()

/// @description pal_swap_get_pal_count(palette sprite)
/// @function pal_swap_get_pal_count
/// @param pal_sprite
function pal_swap_get_pal_count() {
	//returns the number of palettes for the given sprite.
	//Useful for clamping palette selection.
	return(sprite_get_width(argument[0]));
}

#endregion
#region pal_swap_init_system()

/// @description pal_swap_init_system(shader)
/// @function pal_swap_init_system
/// @param Shader
/// @param <HTML5_Sprite_Shader>
/// @param <HTML5_Surface_Shader>
function pal_swap_init_system() {
	//Initiates the palette system.  Call once at the beginning of your game somewhere.
	//IMPORTANT: if you plan on using this for HTML5, you need to specify your two HTML5 
	//versions of the shader.

	globalvar Pal_Shader,Pal_Texel_Size, Pal_UVs, Pal_Index, Pal_Texture, Pal_Shader_Is_Set, 
						Pal_Layer_Priority, Pal_Layer_Temp_Priority, Pal_Layer_Map, 
						Pal_HTML5,Pal_HTML5_Sprite, Pal_HTML5_Surface;
					
	enum Pal_Shader_Type{Standard,HTML_Sprite,HTML_Surface}
	Pal_HTML5 = os_browser != browser_not_a_browser;
	if(!Pal_HTML5)
	{
		Pal_Shader = argument[0];

		Pal_Texel_Size[Pal_Shader_Type.Standard] = shader_get_uniform(Pal_Shader, "u_pixelSize");
		Pal_UVs[Pal_Shader_Type.Standard] = shader_get_uniform(Pal_Shader, "u_Uvs");
		Pal_Index[Pal_Shader_Type.Standard] = shader_get_uniform(Pal_Shader, "u_paletteId");
		Pal_Texture[Pal_Shader_Type.Standard] = shader_get_sampler_index(Pal_Shader, "u_palTexture");

		Pal_Shader_Is_Set = false;
	}
	else
	{
		if(argument_count<3)
		{
			show_message("Must provide pal_swap_init_system() with 2 additional arguments for HTML5 Compatible Sprite and Surface Shaders");
			game_end();
		}
		Pal_HTML5 = true;
		Pal_HTML5_Sprite  = argument[1];
		Pal_HTML5_Surface = argument[2];
	
		Pal_Texel_Size[Pal_Shader_Type.HTML_Sprite] = shader_get_uniform(Pal_HTML5_Sprite, "u_pixelSize");
		Pal_UVs[Pal_Shader_Type.HTML_Sprite] = shader_get_uniform(Pal_HTML5_Sprite, "u_Uvs");
		Pal_Index[Pal_Shader_Type.HTML_Sprite] = shader_get_uniform(Pal_HTML5_Sprite, "u_paletteId");
		Pal_Texture[Pal_Shader_Type.HTML_Sprite] = shader_get_sampler_index(Pal_HTML5_Sprite, "u_palTexture");
	
		Pal_Texel_Size[Pal_Shader_Type.HTML_Surface] = shader_get_uniform(Pal_HTML5_Surface, "u_pixelSize");
		Pal_UVs[Pal_Shader_Type.HTML_Surface] = shader_get_uniform(Pal_HTML5_Surface, "u_Uvs");
		Pal_Index[Pal_Shader_Type.HTML_Surface] = shader_get_uniform(Pal_HTML5_Surface, "u_paletteId");
		Pal_Texture[Pal_Shader_Type.HTML_Surface] = shader_get_sampler_index(Pal_HTML5_Surface, "u_palTexture");
	}

	Pal_Layer_Priority = ds_priority_create();
	Pal_Layer_Temp_Priority = ds_priority_create();
	Pal_Layer_Map = ds_map_create();
}

#endregion
#region pal_swap_reset()

/// @description pal_swap_reset();
/// @function pal_swap_reset
function pal_swap_reset() {
	//Resets the shader
	if(Pal_Shader_Is_Set)
	{
		shader_reset();
	}
	Pal_Shader_Is_Set=false;
}

#endregion
#region pal_swap_set()

/// @description pal_swap_set(palette_sprite_index, palette_index,palette is surface);
/// @function pal_swap_set
/// @param palette_sprite_index
/// @param palette_index
/// @param palette_is_surface
function pal_swap_set(argument0, argument1, argument2) {
	var _pal_sprite=argument0;
	var _pal_index=argument1;

	if(_pal_index==0) exit;

	var mode = Pal_Shader_Type.Standard;

	if(!argument2)
	{   //Using a sprite based palette
			if(Pal_HTML5)
			{
				shader_set(Pal_HTML5_Sprite);
				mode = Pal_Shader_Type.HTML_Sprite;
			}
			else
				shader_set(Pal_Shader);

			Pal_Shader_Is_Set=true;
	    var tex = sprite_get_texture(_pal_sprite, 0);
	    var UVs = sprite_get_uvs(_pal_sprite, 0);
    
	    texture_set_stage(Pal_Texture[mode], tex);
    
	    var texel_x = texture_get_texel_width(tex);
	    var texel_y = texture_get_texel_height(tex);
	    var texel_hx = texel_x * 0.5;
	    var texel_hy = texel_y * 0.5;
    
	    shader_set_uniform_f(Pal_Texel_Size[mode], texel_x, texel_y);
	    shader_set_uniform_f(Pal_UVs[mode], UVs[0] + texel_hx, UVs[1] + texel_hy, UVs[2], UVs[3]);
	    shader_set_uniform_f(Pal_Index[mode], _pal_index);
	}
	else
	{   //Using a surface based palette
			if(Pal_HTML5)
			{
				shader_set(Pal_HTML5_Surface);
				mode=Pal_Shader_Type.HTML_Surface;
			}
			else
				shader_set(Pal_Shader);
    
			Pal_Shader_Is_Set=true;
			var tex = surface_get_texture(_pal_sprite);
    
	    texture_set_stage(Pal_Texture[mode], tex);
    
	    var texel_x = texture_get_texel_width(tex);
	    var texel_y = texture_get_texel_height(tex);
	    var texel_hx = texel_x * 0.5;
	    var texel_hy = texel_y * 0.5;
		
	    //show_message(string_format(texel_x,1,10));
	    //show_message(string_format(texel_y,1,10));
	    shader_set_uniform_f(Pal_Texel_Size[mode], texel_x, texel_y);
	    shader_set_uniform_f(Pal_UVs[mode], texel_hx, texel_hy, 1.0+texel_hx, 1.0+texel_hy);
	    shader_set_uniform_f(Pal_Index[mode], _pal_index);
	}
}

#endregion

#region Layer functions

#region _pal_swap_layer_end()

///You should not be calling this script directly
function _pal_swap_layer_end() {
	if(event_type==ev_draw)
	{
		pal_swap_reset();
		if(ds_priority_empty(Pal_Layer_Priority))
		{
			ds_priority_copy(Pal_Layer_Priority,Pal_Layer_Temp_Priority);
			ds_priority_clear(Pal_Layer_Temp_Priority);
		}
	}
}

#endregion
#region _pal_swap_layer_start()

///You should not be calling this script directly
function _pal_swap_layer_start() {
	if(event_type == ev_draw)
	{
		var _id = ds_priority_delete_min(Pal_Layer_Priority);
		var _data = Pal_Layer_Map[? _id];
		if(ds_list_find_index(_data,undefined)!=-1) exit;
		pal_swap_set(_data[|0],
								 _data[|1],
								 _data[|2]);
		ds_priority_add(Pal_Layer_Temp_Priority,_id,layer_get_depth(_id));
	}
}

#endregion
#region pal_swap_enable_layer()

/// @description pal_swap_enable_layer Enables pal swapping for the given layer.
///***This script sets layer start and end scripts.  And, as suggested by the documentation,
///   this script should not be called in either a step event or a draw event.  It should
///   only be called once.
/// @param layer_index
function pal_swap_enable_layer(argument0) {
	var _layer_index = argument0;

	if(!layer_exists(_layer_index)) return;

	var _data = ds_list_create();

	ds_list_add(_data,undefined,undefined,undefined);

	layer_script_begin(_layer_index,_pal_swap_layer_start);	
	layer_script_end(_layer_index,_pal_swap_layer_end);

	ds_map_add_list(Pal_Layer_Map,_layer_index,_data);
	ds_priority_add(Pal_Layer_Priority,_layer_index,layer_get_depth(_layer_index));
}

#endregion
#region pal_swap_layer_reset()

/// @description pal_swap_layer_reset();  Resets the layer data structures that may already exist.
function pal_swap_layer_reset() {
	// Should be called once before setting up any layers to pal swap.
	ds_map_clear(Pal_Layer_Map);
	ds_priority_clear(Pal_Layer_Priority);
	ds_priority_clear(Pal_Layer_Temp_Priority);
}

#endregion
#region pal_swap_set_layer()

/// @description pal_swap_set_layer draws the specified layer using the specified palette in the specified event.
/// @param pal_sprite the palette to use (sprite or surface).
/// @param pal_index
/// @param layer_index
/// @param pal_is_surface
function pal_swap_set_layer(argument0, argument1, argument2, argument3) {
	var _pal_sprite = argument0,
			_pal_index = argument1,
			_layer_index = argument2,
			_pal_is_surface = argument3;

	var _data = ds_map_find_value(Pal_Layer_Map,_layer_index);
	if(_data == undefined) return;  //Swapping not enabled on this layer
	ds_list_clear(_data);
	ds_list_add(_data,_pal_sprite,_pal_index,_pal_is_surface);


	//Remove from queue if it's already there
	/*if(ds_priority_find_priority(Pal_Layer_Priority,_layer_index) != undefined)
		ds_priority_delete_value(Pal_Layer_Priority,_layer_index);
	if(ds_exists(Pal_Layer_Temp_Priority, ds_type_priority) && 
			ds_priority_find_priority(Pal_Layer_Temp_Priority,_layer_index) != undefined)
		ds_priority_delete_value(Pal_Layer_Temp_Priority,_layer_index);

	//If the layer doesn't exist or pal is 0, clean up pal swapping for that layer.
	if(!_layer_exists || _pal_index == 0)
	{
		if(ds_map_exists(Pal_Layer_Map,_layer_index))
		{
			_data = ds_map_find_value(Pal_Layer_Map,_layer_index);
			ds_map_delete(Pal_Layer_Map,_layer_index);
			if(ds_exists(_data,ds_type_list)) ds_list_destroy(_data);
		}
		
		if(_layer_exists)
		{
			layer_script_begin(_layer_index,noone);	
			layer_script_end(_layer_index,noone);
		}
		return false; //Palswapping on the given layer couldn't be started or you are using your default palette.
	}

	//Else, setup pal swapping for that layer.
	_data = ds_list_create();
	ds_list_add(_data,_pal_sprite,_pal_index,_pal_is_surface);
	layer_script_begin(_layer_index,_pal_swap_layer_start);	
	layer_script_end(_layer_index,_pal_swap_layer_end);
	ds_map_replace(Pal_Layer_Map,_layer_index,_data);
	ds_priority_add(Pal_Layer_Priority,_layer_index,layer_get_depth(_layer_index));

	return true; //Pal Swapping succesfull
/* end pal_swap_set_layer */
}

#endregion

#endregion