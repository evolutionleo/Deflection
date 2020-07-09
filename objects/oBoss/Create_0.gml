/// @desc

// Inherit the parent event
event_inherited();

#region Phases/attacks interface

phase = 1

attacks = [
	[], // Phase 1
	[]	// Phase 2
]

phases = [100, 40]

attack = 1
attack_struct = {}
prev_attack = attack

#endregion
#region Functiions

setAttack = function() {
	prev_attack = attack
	
	while(prev_attack == attack)
	{
		var arr = attacks[phase-1]
		var idx = irandom(array_length(arr)-1)
		
		//show_message(arr)
		//show_message(idx)
		//show_message(arr[idx])
		
		attack_struct = arr[idx]
		attack = idx + 1
		
		if array_length(arr) <= 1
			break
	}
	
	return attack_struct
}

startAttack = function() {
	state = AttackStart
}

actuallyAttack = function() {
	state = Attack
	
	//show_message(attack_struct)

	if !is_undefined(attack_struct.timeline)
	{
		timeline_index = attack_struct.timeline
		timeline_position = 0
		timeline_running = true
		timeline_loop = false
	}
}

endAttack = function() {
	state = AttackEnd
	timeline_running = false
	
	setTimeout(id, function() {
		setAttack()
		startAttack()
	}, attack_struct.rec)
}


die = function() {
	instance_destroy()
}

handleHealth = function() {
	hp = clamp(hp, 0, max_hp)
	
	for (var i = 0; i < array_length(phases); i++)
	{
		if phase != i + 1 and hp / max_hp * 100 <= phases[i]
		{
			phase = i + 1
			//show_debug_message("switching phase to "+string(i+1))
		}
	}
	
	if hp = 0
		die()
}

hit = function(damage, knockback) {
	if is_undefined(damage)
		damage = array_length(phases) - phase + 1
	if is_undefined(knockback)
		knockback = new Vector2(0, 0)
	
	// Impact
	prev_hp2 = hp
	prev_hp2_alpha = 1
	
	if prev_hp == hp
		prev_hp_delay = max_prev_hp_delay
	else
		prev_hp_delay += prev_hp_add_delay
	
	hp -= damage
	
	applySpeed(knockback)
	
	handleHealth()
}
#endregion
#region Misc

prev_hp = hp
max_prev_hp = hp

max_prev_hp_delay = 30
prev_hp_add_delay = 10
prev_hp_delay = 30

//prev_hp_time = 30
prev_hp_speed = .3


prev_hp2 = hp
prev_hp2_delay = 40
prev_hp2_max_delay = 40

prev_hp2_fade = .01
prev_hp2_alpha = 1

#endregion