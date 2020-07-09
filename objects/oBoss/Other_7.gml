/// @desc
switch(state) {
	case AttackStart:
		actuallyAttack()
		break
	case Attack:
		if !timeline_running
			endAttack()
		break
	case AttackEnd:
		state = Chasing
		break
}