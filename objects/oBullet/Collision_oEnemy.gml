/// @desc

if owner == oPlayer and hb_meeting(atk, other.def) and !hitByAttack.Exists(other) {
	other.hit()
	instance_destroy()
	
	hitByAttack.Append(other)
}