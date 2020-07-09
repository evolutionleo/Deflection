/// @desc

seq = layer_sequence_create("Assets_1", room_width/2, room_height/2, sqMenu1)
ended = false

transitionStart = function() {
	if !ended
	{
		layer_sequence_destroy(seq)
		seq = layer_sequence_create("Assets_1", room_width/2, room_height/2, sqMenuEnd)
		ended = true
	}
}

//transitionEnd() is in external script