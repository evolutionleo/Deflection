_dependencies = [
	CounterClass(),
	ArrayClass(),
]

global.message_id = new Counter()

function Event() constructor {
	ev_id = global.message_id.GetCounter()
	//show_message(msg_id)
	
	listeners = new Array()
	
	///@function Fire()
	///@desc	 Fires the event
	Fire = function() {
		listeners.ForEach(function(entry) {
			var listener = entry.listener
			var func = entry.callback
			with(listener) {
				func()
			}
		})
		//self.Destroy()
	}
	
	///@function Listen(listener, func)
	///@param	{real} listener
	///@param	{function} func
	Listen = function(listener, func) {
		var entry = {
			listener: listener,
			callback: func
		}
		listeners.Append(entry)
	}
	
	///@function Destroy()
	Destroy = function() {
		delete listeners
	}
}