/// @desc

applySpeed(velo)

prev_spd.x = spd.x
prev_spd.y = spd.y

collision()

if !in_sequence {
	x = pos.x
	y = pos.y
}
else {
	pos.x = x
	pos.y = y
	
	spd.Subtract(grv) // Don't apply gravity if in sequence
}