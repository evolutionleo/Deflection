_dependencies = [
	SetTimeout()
]

function inheritProps(_props) {
	_props = new Map(_props)
	_props.ForEach(function(val, name) {
		props.Set(name, val)
	})
	delete _props
}

function create_flash(_props) {
	props = new Map({color: c_white, alpha: 1.0, fadespd: .02})
	
	inheritProps(_props)
	
	props = props.content
	
	var flash = instance_create_layer(0, 0, "Effects", oFlash)
	flash.color = props.color
	flash.alpha = props.alpha
	flash.delta_alpha = props.fadespd
}

function create_freeze(_props) {
	props = new Map({time: 100})
	inheritProps(_props)
	
	props = props.content
	
	
	static freeze_limit = 150
	global.freeze += props.time
	
	if global.freeze > freeze_limit {
		props.time -= global.freeze - freeze_limit
		global.freeze = freeze_limit
	}
	
	var target_time = current_time + props.time
	
	while (current_time < target_time) {}
}


global.freeze = 0

function create_sprite(_props) {
	props = new Map(
	{
		x: self.x,
		y: self.y,
		spr: sError,
		img: 0,
		img_spd: 1,
		spd: new Vector2(0, 0),
		alpha: 1.0,
		lifetime: 30,
		fade_offset: 0,
		xscale: 1,
		yscale: 1,
		rotation: 0,
		color: c_white,
		one_cycle: false,
		stuck: noone
	})
	
	inheritProps(_props)
	
	props = props.content
	
	
	var inst = instance_create_layer(props.x, props.y, "Effects", oFloatingSprite)
	inst.sprite_index = props.spr
	inst.image_index = props.img
	inst.alpha = props.alpha
	inst.spd = props.spd
	inst.image_speed = props.img_spd
	inst.lifetime = props.lifetime
	inst.fade_offset = props.fade_offset
	inst.fade_speed = props.alpha/(props.lifetime-props.fade_offset)
	inst.rot = props.rotation
	inst.xs = props.xscale
	inst.ys = props.yscale
	inst.col = props.color
	inst.one_cycle = props.one_cycle
	inst.stuck = props.stuck
}

function create_text(_props) {
	props = new Map({
		x: self.x,
		y: self.y,
		font: noone,
		text: "Sample Text",
		spd: new Vector2(0, 0),
		halign: fa_center,
		valign: fa_middle,
		alpha: 1.0,
		lifetime: 30,
		fade_offset: 0,
		xscale: 1,
		yscale: 1,
		rotation: 0,
		color: c_white,
		stuck: noone
	})
	
	inheritProps(_props)
	
	props = props.content
	
	var inst = instance_create_layer(props.x, props.y, "Effects", oFloatingText)
	inst.text = props.text
	inst.font = props.font
	inst.halign = props.halign
	inst.valign = props.valign
	inst.alpha = props.alpha
	inst.spd = props.spd
	inst.lifetime = props.lifetime
	inst.fade_offset = props.fade_offset
	inst.fade_speed = props.alpha/(props.lifetime-props.fade_offset)
	inst.rot = props.rotation
	inst.xs = props.xscale
	inst.ys = props.yscale
	inst.col = props.color
	inst.stuck = props.stuck
}