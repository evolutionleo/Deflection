/// @desc
if state != Inactive and other.owner != oPlayer
{
	create_sprite({spr: sParry, x: other.x, y: other.y, one_cycle: true, stuck: self})
	setTimeout(method(self, function() {
		create_freeze({ time: 100/(parried+1) })
	}), 2, {})
	
	audio_play_sound(aParry, 1.2, 0)
	
	other.deflect(self)
	other.owner = oPlayer
	parried++
	
	if(state = Active)
		active_time -= max_active_time
	
	active_time = clamp(active_time, 0, max_active_time)
}