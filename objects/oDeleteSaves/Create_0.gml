/// @desc
event_inherited()

onClick = function() {
	deleteSaves()
	audio_play_sound_mute(aHit, 1, 0)
	create_flash({})
}