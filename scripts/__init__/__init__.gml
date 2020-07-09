#region Sound setup

global.audio_emit = audio_emitter_create()

function audio_play_sound_mute(soundid, priority, loops) {
	audio_play_sound_on(global.audio_emit, soundid, loops, priority)
}

function audio_mute() {
	global.mute = !global.mute
	
	audio_emitter_gain(global.audio_emit, !global.mute)
}

function deleteSaves() {
	if instance_exists(oPlayer) oPlayer.upgrades.Clear()
	//if instance_exists(oPalette) {
	//	oPalette.palettes.Clear()
	//	oPalette.palettes.Append(0)
	//	oPalette.palette = 0
	//}
	if instance_exists(oTimer) oTimer.reset()
	
	
	file_delete("upgrades.txt")
	//file_delete("palettes.txt")
	file_delete("coords.ini")

	if room != rMenu
		room_restart()
}


#endregion
#region Electricity stuff

///@param	{int} ch
function sendChannel(ch) {
	oElectricityManager.Power.Set(ch, getChannel(ch)+1)
}

///@param	{int} ch
function getChannel(ch) {
	if oElectricityManager.Power.Size - 1 < ch
		oElectricityManager.Power.Set(ch, 0)
	
	return oElectricityManager.Power.Get(ch)
}

///@param	{int} ch
function streamChannel(ch) {
	oElectricityManager.ConstPower.Set(ch, getChannel(ch)+1)
}

///@param	{int} ch
function unstreamChannel(ch) {
	oElectricityManager.ConstPower.Set(ch, getChannel(ch)-1)
}


///@param	{real} listener
///@param	{int} ch
///@param	{function} func
function listenChannel(listener, ch, func) {
	if oElectricityManager.powerEvents.Size - 1 < ch or oElectricityManager.powerEvents.Get(ch) == 0
		oElectricityManager.powerEvents.Set(ch, new Event())
	
	oElectricityManager.powerEvents.Get(ch).Listen(listener, func)
}

#endregion
#region Flagged collisions

// Flag macros
#macro SOLID 1
#macro MOVING 2
#macro DROPDOWN 3
#macro ONEWAY 4

///@param	_x
///@param	_y
///@param	layer
///@param	object
///@param	{Array} flags
function instance_create_ext(_x, _y, layer, object, flags) {
	__inst = instance_create_layer(_x, _y, layer, object)
	
	flags.ForEach(function(flag) {
		variable_instance_set(__inst, flag, true)
		
		if is_undefined(oInstanceManager.filtered[? flag]) {
			oInstanceManager.filtered[? flag] = new Array()
		}
		
		oInstanceManager.filtered[? flag].Append(__inst)
	})
	
	return __inst
}


function instance_add_flag(inst, flag) {
	if is_undefined(oInstanceManager.filtered[? flag])
		oInstanceManager.filtered[? flag] = new Array()
	
	if !oInstanceManager.filtered[? flag].Exists(inst)
		oInstanceManager.filtered[? flag].Append(inst)
}


function instance_remove_flag(inst, flag) {
	oInstanceManager.filtered[? flag] = oInstanceManager.filtered[? flag].Filter(function(_inst) { return _inst != inst })
}

///@param	_x
///@param	_y
///@param	flag
function place_meeting_flag(_x, _y, flag) {
	_arr = oInstanceManager.filtered[? flag]
	_ans = false
	
	for(var i = 0; i < _arr.Size; ++i) {
		_inst = _arr.Get(i)
		
		if !instance_exists(_inst) {
			oInstanceManager.filtered[? flag].Delete(i)
			i--
			
			continue
		}
		
		if place_meeting(_x, _y, _inst)
			_ans = true
	}
	
	return _ans
}

///@param	_x
///@param	_y
///@param	flag
function position_meeting_flag(_x, _y, flag) {
	_arr = oInstanceManager.filtered[? flag]
	_ans = false
	
	for(var i = 0; i < _arr.Size; ++i) {
		_inst = _arr.Get(i)
		
		if !instance_exists(_inst) {
			oInstanceManager.filtered[? flag].Delete(i)
			i--
			
			continue
		}
		
		if position_meeting(_x, _y, _inst)
			_ans = true
	}
	
	return _ans
}
#endregion
#region Custom Paths

///@param	{int} path_id
///@param	{int} path_pos
function cpath_get_point(_path_id, _path_pos) {
	return global.Paths.Get(_path_id).Get(_path_pos)
}
#endregion

// Pure evil

//#macro true random(1) < .6;
