/// @desc
str = ""
time = 0
stopped = false
offset = current_time


formatTime = function(time, digits) {
	_str = string(time)
	repeat(digits - string_length(_str)) {
		_str = "0"+_str
	}
	
	return _str
}

reset = function() {
	offset = current_time
}

stop = function() {
	stopped = true
}

start = function() {
	stopped = false
}