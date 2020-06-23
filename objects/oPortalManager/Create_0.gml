/// @desc
global.portals = new Array()

with(oTeleporter)
{
	if !variable_instance_exists(self, "object_index")
		exit
	
	var tp = self
	//show_message(self)
	//show_message(self.portal_id)
	global.portals.Set(tp.portal_id, tp)
	//global.portals.Set(other.tp.portal_id, other.tp)
}