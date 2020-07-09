/// @desc

if !ghost and hb_meeting(atk, other.atk)
{
	if !other.ghost
		instance_destroy(other)
}