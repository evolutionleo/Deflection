/// @desc

// Inherit the parent event
event_inherited();


cooldown = 90


def = hb_add(id,"def", hTurtle_def)
atk = hb_add(id,"atk", hTurtle_atk)

state = Walk

alarm[1] = cooldown