/// @desc
var msg = event_data[? "message"]

if string_pos("End", msg) {
	// Attack end
	state = Idle
	
	//if(phase == 1) {
	var delay = attacks.Get(attack).recovery
	getAttack()
	//show_message(attack)
	//show_message(phase)
	
	setTimeout(method(self, function() { startAttack() }), delay, {})
	//}
}