/// @desc
#region Input

krest = Input.get("restart")
kesc = Input.get("quit")

kup = Input.getPressed("down")
kdown = Input.get("down")

if krest and global.camera_ready {
	if !file_exists("upgrades.txt")
		oTimer.reset()
	die()
}
if kesc
	room_goto(rMenu)

kjump = Input.getJump()
kjump_rel = Input.getReleased("jump")
kjump_hold = Input.get("jump")

kdash = Input.getPressed("dash")

kslide = Input.getPressed("slide")

move = new Vector2(Input.getAxis("Horizontal"), Input.getAxis("Vertical"))

#endregion
#region Buffering
if kjump {
	buffer.jump = buffer._max.jump
}
if onGround() {
	buffer.ground = buffer._max.ground
	air_jumps = 0
	
	if buffer.dash < 0
		dashes = 0
}
else {
	buffer.midair = buffer._max.midair
}


if kdown {
	buffer.dropdown = buffer._max.dropdown
}

buffer.ground--
buffer.jump--
buffer.iframes--
buffer.dash--
buffer.midair--
buffer.save--
buffer.afterdash--
buffer.dropdown--

#endregion
#region Velocity

velo.Zero()
if(abs(spd.x) <= max_base_xsp or move.x != sign(spd.x))
	applySpeed(move.Multiplied(acc))

if state != Dash
	applySpeed(grv)

#region Jumping

if onGround() or buffer.ground
{
	if kjump or buffer.jump
	{
		jump()

		if !kjump_hold
		{
			spd.y = jump_vec.y/2
		}
	}
}
else if kjump_rel and spd.y <= jump_vec.y/2
{
	spd.y = jump_vec.y/2
}
else if wall_jump and kjump and state == WallSlide //and nextToWall() != 0
{
	side = nextToWall()
	walljump(side)
}
else if kjump
{
	airJump()
}
else if kjump_hold and spd.y < 0
{
	applySpeed(add_jump_vec.Multiplied(new Vector2(move.x, 1)))
}
#endregion
#region Dashing
if kdash and dashes < max_dashes {
	buffer.dash = buffer._max.dash
	dash()
}
#endregion

#endregion
#region Dreamblock

tile3 = meetingDreamblock(pos.x, pos.y)

if buffer.afterdash == 1 and meetingDreamblock(pos.x + spd.x, pos.y + spd.y)
	buffer.afterdash = 2

if (buffer.afterdash > 0) and tile3 { //state == Dash || 
	spd.x = prev_spd.x
	spd.y = prev_spd.y
	//buffer.afterdash = buffer._max.afterdash
	buffer.afterdash = 2
	state = Dash
	
	if spd.Hypotenuse() < dash_spd { // Don't go terribly slow
		_dir = pdir(0, 0, spd.x, spd.y)
		spd.x = lengthdir_x(dash_spd, _dir)
		spd.y = lengthdir_y(dash_spd, _dir)
	}
	
	
	if !meetingDreamblock(pos.x+spd.x, pos.y+spd.y) // Leaving Dreamblock
	{
		dashes = 0
		air_jumps = 0
		buffer.afterdash = 1
		
		
		state = Jump // Don't apply dash buffer again
	}
}

#endregion

//spd.Add(add_spd)


spd.Clamp(min_spd, max_spd)
event_inherited()


//spd.Subtract(add_spd)

#region Friction/Decceleration
decc = fric

side = nextToWall()

if state == ShieldSlide {
	decc = decc.shield
}
else if onGround()
	decc = decc.ground
else if side != 0 and !onGround()
	decc = decc.wall
else
	decc = decc.air

if state == ShieldSlide and abs(spd.x) > 2 and onGround()
{
	repeat(5)
	{
		xx = random_range(bbox_left, bbox_right)
		yy = bbox_bottom + random_range(-1, 2)
		part = instance_create_layer(xx, yy, "Effects", oSlideParticle)
		part.direction = 135 + random_range(-30, 30)
	}
}


if state == Dash {
	decc = decc.dash
	target_xspd = 0
	target_yspd = 0
}
else if move.x == 0 {
	decc = decc.stop
	target_xspd = 0
	target_yspd = 0
}
else if (state == WallSlide and move.x == side) {
	decc = decc.move
	target_xspd = max_base_xsp
	target_yspd = max_base_ysp
	
	#region Friction particles
	
	repeat(5)
	{
		xx = x + side * (abs(sprite_width) / 2) + random_range(1, 6) * side
		yy = random_range(bbox_top, bbox_bottom)
		part = instance_create_layer(xx, yy, "Effects", oWallParticle)
		//part.direction = point_direction(0, 0, side, 0) + random_range(-60, 60)
		part.direction = point_direction(0, 0, 0, -1) + random_range(-90, 10) * -side
	}
	
	#endregion
}
else if (state != WallSlide and move.x == sign(spd.x)) {
	decc = decc.move
	target_xspd = max_base_xsp
	target_yspd = max_base_ysp
}
else {
	decc = decc.reverse
	target_yspd = 0
	target_xspd = 0
}

target_xspd = 0
target_yspd = 0

spd.x = lerp(spd.x, target_xspd, decc[0])
if spd.y > 0 or state == Dash
	spd.y = lerp(spd.y, 0, decc[1])

#endregion
#region Interaction
if (onGround())
{
	if place_meeting(pos.x, pos.y, oTeleporter)
	{
		if !buffer.save
			save()
		
		buffer.save = buffer._max.save
		hp = max_hp
		
		//if kup
		if false
			instance_place(pos.x, pos.y, oTeleporter).teleport(self)
	}
}
#endregion
#region Speedy effect (shadow)

if abs(spd.x) > 8
{
	buffer.shadow--
	if !buffer.shadow
	{
		xx = pos.x
		yy = pos.y
		
		part = instance_create_layer(xx, yy, "Effects", oSpeedParticle)
		part.direction = point_direction(0, 0, -spd.x, 0)
		//part.sprite_index = sprite_index
		//part.image_index = image_index
		part.image_speed = 0
		
		
		buffer.shadow = buffer._max.shadow
	}
}
#endregion