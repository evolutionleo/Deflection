/// @desc

//setTimeout(self, function() {

global.portals = new Array()

with(oTeleporter)
{
	if !variable_instance_exists(self, "object_index")
		exit
	
	var tp = self
	global.portals.Set(tp.portal_id, tp)
}

//}, 1)