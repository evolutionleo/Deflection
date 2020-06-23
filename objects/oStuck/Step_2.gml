///@desc

if !instance_exists(target)
	target = noone

if target != noone
{
	xoff = (xoff == "auto")
		? x - target.x
		: xoff

	yoff = (yoff == "auto")
		? y - target.y
		: yoff
	
	x = target.x + xoff
	y = target.y + yoff
}