///@function	FadeIn(time, *obj, *func)
///@description	Slowly increases alpha of an object to 1.0
///@param		{real} time Time in frames before reaching full alpha
///@param		{real} *obj Instance to fade (default self)
///@param		{function} *func Function to execute after the fading is finished
function FadeIn(time, obj, func) {
	#region Dealing with undefined
	
	if(is_undefined(func))
		func = function() { };
	
	if(is_undefined(obj))
		obj = self;
	
	#endregion
	#region Sequence setup
	
	#region Overall sequence setup
	//Create sequence
	var seq = sequence_create();
	seq.length = time;
	seq.playbackMode = seqplay_oneshot;
	
	//Create sequence track
	var tracks = array_create(1);
	tracks[0] = sequence_track_new(seqtracktype_instance);
	
	//Create keyframes
	var keys = array_create(1);
	keys[0] = sequence_keyframe_new(seqtracktype_instance);
	keys[0].frame = 0;
	keys[0].disabled = false;
	keys[0].length = 1;
	keys[0].stretch = true;
	
	//Create structs, containing keyframe data for previous frames
	var keydata = array_create(1);
	keydata[0] = sequence_keyframedata_new(seqtracktype_instance);
	keydata[0].objectIndex = obj.object_index;
	keydata[0].channel = 0;
	
	keys[0].channels = keydata;
	
	//Set the name and the keyframes for the sequence track
	tracks[0].name = "FadeTrack";
	tracks[0].keyframes = keys;
	
	//Create sub-tracks, containing actual info
	var paramtracks = array_create(2);
	//var paramtracks = array_create(3);
	
	paramtracks[0] = sequence_track_new(seqtracktype_color);
	paramtracks[0].name = "blend_multiply";
	paramtracks[0].interpolation = true;
	
	paramtracks[1] = sequence_track_new(seqtracktype_real);
	paramtracks[1].name = "position";
	paramtracks[1].interpolation = true;
	
	//paramtracks[2] = sequence_track_new(seqtracktype_moment);
	//paramtracks[2].name = "moment"; //Unnesessary
	
	#endregion
	#region Color keyframes
	var colorkeys = array_create(2);
	colorkeys[0] = sequence_keyframe_new(seqtracktype_color);
	colorkeys[0].frame = 0;
	colorkeys[1] = sequence_keyframe_new(seqtracktype_color);
	colorkeys[1].frame = time;
	
	// Create the keyframe struct to hold the parameter channel data and set the frame position for the keyframe
	var colordata1 = array_create(1);
	colordata1[0] = sequence_keyframedata_new(seqtracktype_color);
	colordata1[0].channel = 0;
	colordata1[0].color = [obj.image_alpha, 1, 1, 1];
	

	//Create array to hold param key data in [A, R, G, B] format
	var colordata2 = array_create(1);
	colordata2[0] = sequence_keyframedata_new(seqtracktype_color);
	colordata2[0].channel = 0;
	colordata2[0].color = [1.0, 1, 1, 1];

	
	// Assign the keyframe data structs to the channels for each key
	colorkeys[0].channels = colordata1;
	colorkeys[1].channels = colordata2;
	#endregion
	#region Pos keyframes
	var poskeys = array_create(2);
	poskeys[0] = sequence_keyframe_new(seqtracktype_real);
	poskeys[0].frame = 0;
	poskeys[1] = sequence_keyframe_new(seqtracktype_real);
	poskeys[1].frame = time;
	
	
	var posdata1 = array_create(2);
	posdata1[0] = sequence_keyframedata_new(seqtracktype_real);
	posdata1[0].name = "position";
	posdata1[0].channel = 0; // X
	posdata1[0].value = obj.x;
	posdata1[1] = sequence_keyframedata_new(seqtracktype_real);
	posdata1[1].name = "position";
	posdata1[1].channel = 1; // Y
	posdata1[1].value = obj.y;
	
	var posdata2 = array_create(2);
	posdata2[0] = sequence_keyframedata_new(seqtracktype_real);
	posdata2[0].name = "position";
	posdata2[0].channel = 0; // X
	posdata2[0].value = obj.x;
	posdata2[1] = sequence_keyframedata_new(seqtracktype_real);
	posdata2[1].name = "position";
	posdata2[1].channel = 1; // Y
	posdata2[1].value = obj.y;
	
	
	poskeys[0].channels = posdata1;
	poskeys[1].channels = posdata2;
	#endregion
	#region //Moment (Code) keyframes - Not supported yet
	
	//var codekeys = array_create(1);
	
	//codekeys[0] = sequence_keyframe_new(seqtracktype_moment);
	//codekeys[0].frame = time;
	
	
	//var codedata = array_create(1);
	//codedata[0] = sequence_keyframedata_new(seqtracktype_moment);
	//codedata[0].channel = 0;
	//codedata[0].event = method(obj, func);
	
	//codekeys[0].channels = codedata[0];
	
	#endregion
	#region Overall setup 2
	// Assign the keys to the parameter track
	paramtracks[0].keyframes = colorkeys;
	paramtracks[1].keyframes = poskeys;
	//paramtracks[2].keyframes = codekeys;
	tracks[0].tracks = paramtracks;
	seq.tracks = tracks;
	
	#endregion
	
	#endregion
	
	DelayedFunction(func, time, false)
	
	#region Firing the sequence
	
	var seqID = layer_sequence_create("Instances", 0, 0, seq);
	var seqInst = layer_sequence_get_instance(seqID);
	sequence_instance_override_object(seqInst, obj.object_index, obj);
	
	#endregion
}


///@function	FadeOut(time, *obj, *func(unsupported))
///@description	Slowly decreases alpha of an object to zero
///@param		{real} time Time in frames before reaching 0 alpha
///@param		{real} *obj Instance to fade (default self)
///@param		{function} *func(unsupported) Function to execute after the fading is finished
function FadeOut(time, obj, func) {
	#region Dealing with undefined
	
	if(is_undefined(func))
		func = function() { };
	
	if(is_undefined(obj))
		obj = self;
	
	#endregion
	#region Sequence setup
	
	#region Overall sequence setup
	//Create sequence
	var seq = sequence_create();
	seq.length = time;
	seq.playbackMode = seqplay_oneshot;
	
	//Create sequence track
	var tracks = array_create(1);
	tracks[0] = sequence_track_new(seqtracktype_instance);
	
	//Create keyframes
	var keys = array_create(1);
	keys[0] = sequence_keyframe_new(seqtracktype_instance);
	keys[0].frame = 0;
	keys[0].disabled = false;
	keys[0].length = 1;
	keys[0].stretch = true;
	
	//Create structs, containing keyframe data for previous frames
	var keydata = array_create(1);
	keydata[0] = sequence_keyframedata_new(seqtracktype_instance);
	keydata[0].objectIndex = obj.object_index;
	keydata[0].channel = 0;
	
	keys[0].channels = keydata;
	
	//Set the name and the keyframes for the sequence track
	tracks[0].name = "FadeTrack";
	tracks[0].keyframes = keys;
	
	//Create sub-tracks, containing actual info
	var paramtracks = array_create(2);
	//var paramtracks = array_create(3);
	
	paramtracks[0] = sequence_track_new(seqtracktype_color);
	paramtracks[0].name = "blend_multiply";
	paramtracks[0].interpolation = true;
	
	paramtracks[1] = sequence_track_new(seqtracktype_real);
	paramtracks[1].name = "position";
	paramtracks[1].interpolation = true;
	
	//paramtracks[2] = sequence_track_new(seqtracktype_moment);
	//paramtracks[2].name = "moment"; //Unnesessary
	
	#endregion
	#region Color keyframes
	var colorkeys = array_create(2);
	colorkeys[0] = sequence_keyframe_new(seqtracktype_color);
	colorkeys[0].frame = 0;
	colorkeys[1] = sequence_keyframe_new(seqtracktype_color);
	colorkeys[1].frame = time;
	
	// Create the keyframe struct to hold the parameter channel data and set the frame position for the keyframe
	var colordata1 = array_create(1);
	colordata1[0] = sequence_keyframedata_new(seqtracktype_color);
	colordata1[0].channel = 0;
	colordata1[0].color = [obj.image_alpha, 1, 1, 1];
	

	//Create array to hold param key data in [A, R, G, B] format
	var colordata2 = array_create(1);
	colordata2[0] = sequence_keyframedata_new(seqtracktype_color);
	colordata2[0].channel = 0;
	colordata2[0].color = [0, 1, 1, 1];

	
	// Assign the keyframe data structs to the channels for each key
	colorkeys[0].channels = colordata1;
	colorkeys[1].channels = colordata2;
	#endregion
	#region Pos keyframes
	var poskeys = array_create(2);
	poskeys[0] = sequence_keyframe_new(seqtracktype_real);
	poskeys[0].frame = 0;
	poskeys[1] = sequence_keyframe_new(seqtracktype_real);
	poskeys[1].frame = time;
	
	
	var posdata1 = array_create(2);
	posdata1[0] = sequence_keyframedata_new(seqtracktype_real);
	posdata1[0].name = "position";
	posdata1[0].channel = 0; // X
	posdata1[0].value = obj.x;
	posdata1[1] = sequence_keyframedata_new(seqtracktype_real);
	posdata1[1].name = "position";
	posdata1[1].channel = 1; // Y
	posdata1[1].value = obj.y;
	
	var posdata2 = array_create(2);
	posdata2[0] = sequence_keyframedata_new(seqtracktype_real);
	posdata2[0].name = "position";
	posdata2[0].channel = 0; // X
	posdata2[0].value = obj.x;
	posdata2[1] = sequence_keyframedata_new(seqtracktype_real);
	posdata2[1].name = "position";
	posdata2[1].channel = 1; // Y
	posdata2[1].value = obj.y;
	
	
	poskeys[0].channels = posdata1;
	poskeys[1].channels = posdata2;
	#endregion
	#region //Moment (Code) keyframes - Not supported yet
	
	//var codekeys = array_create(1);
	
	//codekeys[0] = sequence_keyframe_new(seqtracktype_moment);
	//codekeys[0].frame = time;
	
	
	//var codedata = array_create(1);
	//codedata[0] = sequence_keyframedata_new(seqtracktype_moment);
	//codedata[0].channel = 0;
	//codedata[0].event = method(obj, func);
	
	//codekeys[0].channels = codedata[0];
	
	#endregion
	#region Overall setup 2
	// Assign the keys to the parameter track
	paramtracks[0].keyframes = colorkeys;
	paramtracks[1].keyframes = poskeys;
	//paramtracks[2].keyframes = codekeys;
	tracks[0].tracks = paramtracks;
	seq.tracks = tracks;
	
	#endregion
	
	#endregion
	
	DelayedFunction(func, time, false)
	
	#region Firing the sequence
	
	var seqID = layer_sequence_create("Instances", 0, 0, seq);
	var seqInst = layer_sequence_get_instance(seqID);
	sequence_instance_override_object(seqInst, obj.object_index, obj);
	
	#endregion
}
