/// @desc

// Inherit the parent event
event_inherited();

#region Attacks & phases

attacks = {
	_1_1: {
		relative: true,
		recovery: 30
	},
	_1_2: {
		relative: false,
		recovery: 120
	},
	_1_3: {
		relative: false,
		recovery: 60
	},
	_2_0: {
		
	}
}


attacks = new Map(attacks)
attacks.ForEach(function(_attack, name) {
	_attack.target = noone
	
	with(oTarget) {
		if self.attack == name
			_attack.target = self
	}
	_attack.seq = asset_get_index("sqReflection"+name)
	//if !_attack.seq { }
})

//attacks = attacks.content



phase = 1

#endregion
#region Functions

getAttack = function() {
	//if !done_initial_attack
	//	return "_2_0"
	previous_attack = attack
	
	while(attack == previous_attack)
	{
		var _attack
		
		//show_message(phase)
		
		switch(phase)
		{
			case 1:
				_attack = irandom_range(1, 3)
				break
			case 2:
				_attack = 0
				break
			case 3:
				_attack = 1
				break
		}
		
		attack = "_"+string(phase)+"_"+string(_attack)
		
		if phase == 3 or phase == 2{
			break
		}
	}
	
	return attack
}

handleHealth = function() {
	
	if hp < max_hp*.4 {
		phase = 2
		done_initial_attack = false
	}
	//else if hp < max_hp*.1 {
	//	phase = 3
	//}
	
	hp = clamp(hp, 0, max_hp)
	if hp = 0 {
		instance_destroy()
		room_goto(rWin)
		file_delete("upgrades.ini")
	}
}


startAttack = function() {
	//attack = getAttack()
	show_debug_message(attack)
	if attack == "_2_0"
	{
		state = Attack
		
		with(oPathPoint)
		{
			var inst = instance_create_layer(x, y, "Enemies", oReflection_copy_flying)
			inst.path_pos = path_pos
		}
		
		pos.x = 0
		pos.y = 0
		x = 0
		y = 0
	}
	else {
		state = Attack

		if (attacks.Get(attack).relative)
		{
			var xx = x
			var yy = y
		}
		else
		{
			xx = oCenter.x
			yy = oCenter.y
		}
		var lay = layer_sequence_create("Attacks", xx, yy, attacks.Get(attack).seq)
		var inst = layer_sequence_get_instance(lay)
		sequence_instance_override_object(inst, oReflection, self)
	}
}


hit = function(_damage) {
	hp -= _damage
	handleHealth()
	
}

#endregion
#region State

#macro MovingToAttack 200

flying = false

attack = -1
previous_attack = -1

done_initial_attack = true


state = Idle

getAttack()
startAttack()
#endregion

max_hp = 100
hp = max_hp

if debug_mode
	hp = max_hp*.41