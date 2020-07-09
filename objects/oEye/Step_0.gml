/// @desc

if phase == 2 {
	if distance_to_object(oPlayer) > 144
		base_spd = new Vector2(7, 7)
	else
		base_spd = new Vector2(5, 5)
}


if state == Chasing
	setSpeed(move.Multiplied(base_spd))
else
	setSpeed(toVector2(0))

event_inherited()


if hb_meeting(atk, oPlayer.def) {
	oPlayer.hit()
}