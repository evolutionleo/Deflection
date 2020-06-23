/// @desc


var other_hb = hb_get(other, "def")
if !hb_meeting(hb, other_hb)
	exit

if owner != oPlayer and !hitByAttack.Exists(other) {
	other.hit()
	hitByAttack.Append(other)
	
	onCollision()
}