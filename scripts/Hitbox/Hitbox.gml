_dependencies = [
	MapClass()
]

// Functional style

// In theory you shouldn't ever use this function, 
// but actually it's equivalent to hb_add()
function __hb_inst(_owner, _name, _spr) {
	static _counter = new Counter()
	_id = _counter.GetCounter()
	
	_struct = {
		_id	 : _id,
		owner: _owner,
		name : _name,
		spr  : _spr,
		x: _owner.x,
		y: _owner.y
		
	}
	//with(oHitboxManager) {
		//show_message(se("Adding new hb. List: %, HB: %", hitboxes.Append(struct), struct))
		var __PEPEGA = oHitboxManager.hitboxes.Append(_struct)
	//}
	
	return _id
}

//function hb_add(id,inst, name, sprite) {
	
//	if ( !variable_instance_exists(self, "hitboxes") ) { self.hitboxes = new Map() }
	
	
//	var inst = instance_create_layer(self.x, self.y, self.layer, oHitbox)
//	inst.sprite_index = sprite
//	inst.image_xscale = id.image_xscale
//	inst.image_yscale = id.image_yscale
//	inst.target = id
	
//	self.hitboxes.Set(name, inst)
	
//	return inst
//}
function hb_add(inst, name, sprite) {
	return __hb_inst(inst, name, sprite)
}

function hb_get(inst, name) {
	//if ( !variable_instance_exists(id, "hitboxes") ) { id.hitboxes = new Map() }
	//return inst.hitboxes.Get(name)
	__target = undefined
	//with(oHitboxManager)
	//{
		oHitboxManager.hitboxes.ForEach(function(hb)
		{
			if hb.name == name and hb.inst == inst
			{
				__target = hb
				return 1
			}
		})
	//}
	
	return __target
}

function __hb_find(_id) {
	ans = undefined
	
	try {
	//with(oHitboxManager)
	//{
		self._id = _id
		oHitboxManager.hitboxes.ForEach(function(_hb)
		{
			hb = _hb
			
			if hb._id == _id
			{
				ans = hb
				return 1
			}
		})
	//}
	
	return ans
	}
	catch(e) { return ans }
}

function hb_meeting(hb1, hb2) {
	//with (hb1) { return place_meeting(x, y, hb2) }
	with(oHitboxManager)
	{
		hb1 = __hb_find(hb1)
		hb2 = __hb_find(hb2)
		
		flag = false
		
		if is_undefined(hb1) || !instance_exists(hb1.owner) {
			hb_destroy(hb1)
			flag = true
		}
		if is_undefined(hb2) || !instance_exists(hb2.owner) {
			hb_destroy(hb2)
			flag = true
		}	
		
		if flag
			return false
		
		with(checker1)
		{
			mask_index = hb1.spr
			sprite_index = hb1.spr
			x = hb1.owner.x
			y = hb1.owner.y
			image_xscale = hb1.owner.image_xscale
			image_yscale = hb1.owner.image_yscale
			image_angle = hb1.owner.image_angle
		}
		with(checker2)
		{
			mask_index = hb2.spr
			sprite_index = hb2.spr
			x = hb2.owner.x
			y = hb2.owner.y
			image_xscale = hb2.owner.image_xscale
			image_yscale = hb2.owner.image_yscale
			image_angle = hb2.owner.image_angle
			
			
			return distance_to_object(other.checker1) < 32 and place_meeting(x, y, other.checker1)
		}
	}
	
	return false
}

function hb_destroy(_id) {
	//instance_destroy(hb_get(id, name))
	
	//with(oHitboxManager)
	//{
		id._id = _id
		oHitboxManager.hitboxes = oHitboxManager.hitboxes.Filter(function(hb) {
			return !is_undefined(hb) and variable_struct_exists(hb, "_id") and !is_undefined(hb._id) and hb._id != _id
		})
	//}
}