/// @desc

// Inherit the parent event
event_inherited();


onClick = function() {
	if !instance_exists(oPalette) or oPalette.palettes.Size <= 1 {
		create_text({font: fPixel, text: "No palettes unlocked!", x: room_width/2, y: room_height/2-128})
	}
	else oPalette.increment()
}

onDefault = function() {
	image_speed = 0
}

onHover = function() {
	image_speed = 1
}