/// @desc

//if variable_instance_exists(self, "hitboxes")
//{
	//hitboxes.ForEach(function(hb, name) {hb_destroy(name)})
	//delete hitboxes
	//hitboxes.ForEach(function(hb, hb_name) { instance_destroy(hb)})
//}

if variable_instance_exists(self, "atk")
	hb_destroy(atk)
if variable_instance_exists(self, "def")
	hb_destroy(def)