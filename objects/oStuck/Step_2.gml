///@desc

if target != noone and instance_exists(target)
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