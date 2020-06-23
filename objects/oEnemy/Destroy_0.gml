/// @desc

if variable_instance_exists(self, "hitboxes")
{
	//hitboxes.ForEach(function(hb, name) {hb_destroy(name)})
	//delete hitboxes
	hitboxes.ForEach(function(hb) { instance_destroy(hb)})
}