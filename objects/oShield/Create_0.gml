/// @desc
#macro Inactive 0
#macro Deactivating 1
#macro Activating 2
#macro Active 3

Input = require("input")
Input.addBind("parry", -mb_left)

state = Inactive


parried = 0

//blinking = false
//setInterval(function() { 
//	if active_time <= max_active_time/3 and state == Active
//		blinking = !blinking
//	else
//		blinking = false
//}, 5)


active_time = 0
max_active_time = 15

cooldown = 0
max_cooldown = 120


pos = new Vector2(x, y)