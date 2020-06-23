/// @desc
#region Input

krest = Input.get("restart")
kesc = Input.get("quit")

kup = Input.getPressed("down")

if krest
	room_restart()
if kesc
	game_end()

kjump = Input.getJump()
kjump_rel = Input.getReleased("jump")
kjump_hold = Input.get("jump")

move = new Vector2(Input.getAxis("Horizontal"), Input.getAxis("Vertical"))

#endregion
#region Buffering
if kjump {
	buffer.jump = buffer._max.jump
}
if onGround() {
	buffer.ground = buffer._max.ground
	air_jumps = 0
}

buffer.ground--
buffer.jump--
buffer.iframes--

#endregion
#region Velocity

velo.Zero()
if(abs(spd.x) <= max_base_xsp or move.x != sign(spd.x))
	applyVelocity(move.Multiplied(acc))
applyVelocity(grv)

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
else if kjump
{
	airJump()
}
else if kjump_hold and spd.y < 0
{
	applySpeed(add_jump_vec.Multiplied(new Vector2(move.x, 1)))
}
#endregion

#endregion

event_inherited()

#region Friction/Decceleration
decc = fric

if onGround()
	decc = decc.ground
else
	decc = decc.air

if move.x == 0 {
	decc = decc.stop
	target_spd = 0
}
else if move.x == sign(move.x) {
	decc = decc.move
	target_spd = max_base_xsp
}
else {
	decc = decc.reverse
	target_spd = 0
}

spd.x = lerp(spd.x, 0, decc)
#endregion
#region Interaction
if (kup and onGround())
{
	if place_meeting(pos.x, pos.y, oTeleporter)
	{
		save()
		instance_place(pos.x, pos.y, oTeleporter).teleport(self)
	}
}
#endregion

spd.Clamp(min_spd, max_spd)