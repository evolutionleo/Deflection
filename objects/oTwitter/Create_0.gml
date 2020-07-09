/// @desc

// Inherit the parent event
event_inherited();

onClick = function() {
	url_open("https://twitter.com/Evoleodev")
}

onDefault = function() {
	image_index = 0
}

onHold = function() {
	image_index = 0
}

onHover = function() {
	image_index = 1
}