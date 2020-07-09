/// @desc

// Inherit basic physics behaviour
event_inherited()

if(flying)
{
	base_spd = new Vector2(sp, sp)
	counter_spd = new Vector2(countersp, countersp)
}
else
{
	base_spd = new Vector2(sp, 0)
	counter_spd = new Vector2(countersp, 0)
}

min_spd = new Vector2(-max_xspd, -max_yspd)
max_spd = new Vector2(max_xspd, max_yspd)


knockback = new Vector2(xknock, yknock)

function create_poof() {
	return create_sprite({spr: sPoof})
}

die = function() {
	create_poof()
	audio_play_sound_mute(aEnemyHit, 0, 0)
	create_freeze({time: 50})
	instance_destroy()
}

handleHealth = function() {
	hp = clamp(hp, 0, max_hp)
	
	if hp = 0 {
		die()
	}
}

hit = function(damage, knock) {
	if is_undefined(damage)
		damage = .5
	
	if is_undefined(knock)
		knock = new Vector2(0, 0)
	
	applySpeed(knock)
	hp -= damage
	
	handleHealth()
}

state = Idle