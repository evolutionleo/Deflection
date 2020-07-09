/// @desc Deflect!
if state != Inactive and other.owner != oPlayer
{
	create_sprite({spr: sParry, x: other.x, y: other.y, one_cycle: true, stuck: self})
	
	
	if other.antishield {
		active_time = 0
		state = Inactive
	}
	else {
		parried++
		//setTimeout(self, function() {
			create_freeze({ time: 50/parried })
		//}, 2)
	
	
		audio_play_sound_mute(aParry, 1.2, 0)
		other.deflect(self)
		other.owner = oPlayer
	
		var bounce = new Vector2(0, -8.5)
	
		if state == Slide or state == SlideStart {
			oPlayer.jump(bounce)
			oPlayer.air_jumps = 0
			oPlayer.dashes = 0
		}
	
	
		if oPlayer.shield_jump {
			oPlayer.air_jumps = 0
		}
	
	
		if(state = Active)
			active_time += real_max_active_time
	
		active_time = clamp(active_time, 0, real_max_active_time)
	}
}