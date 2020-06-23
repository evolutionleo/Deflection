/// @desc

applySpeed(velo)

collision()

if !in_sequence {
	x = pos.x
	y = pos.y
}
else {
	pos.x = x
	pos.y = y
	
	spd.Subtract(grv)
}