/// @desc
Paths = new Array()

//DelayedFunction(function() {
	with(oPathPoint) {
		if is_struct(self)
			exit
		
		if(other.Paths.Size-1 < path_id or !is_Array(other.Paths.Get(path_id))) {
			other.Paths.Set(path_id, new Array())
		}
		
		//show_message(other.Paths)
		//show_message(path_id)
		
		var my_path = other.Paths.Get(path_id)
		my_path.Set(path_pos, id)
	}
//}, 1)

//show_message(Paths)

global.Paths = Paths