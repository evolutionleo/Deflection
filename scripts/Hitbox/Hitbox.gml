_dependencies = [
	MapClass()
]

// Functional style

function hb_add(name, sprite) {
	if ( !variable_instance_exists(self, "hitboxes") ) { self.hitboxes = new Map() }
	
	
	var inst = instance_create_layer(self.x, self.y, self.layer, oHitbox)
	inst.sprite_index = sprite
	inst.image_xscale = self.image_xscale
	inst.image_yscale = self.image_yscale
	inst.target = self
	
	self.hitboxes.Set(name, inst)
	
	return inst
}

function hb_get(inst, name) {
	if ( !variable_instance_exists(id, "hitboxes") ) { self.hitboxes = new Map() }
	return inst.hitboxes.Get(name)
}

function hb_meeting(hb1, hb2) {
	with (hb1) { return place_meeting(x, y, hb2) }
}

function hb_destroy(name) {
	instance_destroy(hb_get(self, name))
}