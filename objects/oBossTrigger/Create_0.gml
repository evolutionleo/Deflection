/// @desc

event_inherited()

onActivation = function() {
	boss = instance_create_layer(x, y, "Enemies", boss);
	var map = new Map(properties)
	map.ForEach(function(val, name) {
		variable_instance_set(boss, name, val)
	})
	instance_destroy()
}