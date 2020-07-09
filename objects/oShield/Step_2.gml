/// @desc Handle States

if state == SlideStart
{
	if radius > 2
		radius -= 2
	else {
		radius = 2
		state = Slide
	}
	
	if oPlayer.state != ShieldSlide
		state = Inactive
	
	
	target_dir = DOWN
	target_x = oPlayer.x
	target_y = oPlayer.y + radius
}
else if state == Slide
{
	radius = 2
	
	
	if oPlayer.state != ShieldSlide
		state = Inactive
	
	target_dir = DOWN
	target_x = oPlayer.x
	target_y = oPlayer.y + radius
}
else
{
	radius = 18
	
	
	target_x = mouse_x
	target_y = mouse_y

	target_dir = point_direction(oPlayer.x, oPlayer.y, target_x, target_y)
}

diff = angle_difference(image_angle, target_dir)

if point_distance(oPlayer.x, oPlayer.y, target_x, target_y) > radius
{
	image_angle -= diff/4
}
else
{
	image_angle -= diff/10
}

x = oPlayer.x + lengthdir_x(radius*image_xscale, image_angle)
y = oPlayer.y + lengthdir_y(radius*image_yscale, image_angle)

pos = new Vector2(x, y)


#region Switch state

switch(state) {
	case Inactive:
		spr = sEShieldInactive
		image_speed = 0
		
		cooldown--
		cooldown = clamp(cooldown, 0, max_cooldown)
		
		if Input.getPressed("parry") and cooldown == 0 {
			state = Activating
		}
		
		break
	case Active:
		spr = sEShieldActive
		image_speed = 0
		
		active_time--
		
		if Input.getPressed("parry") {
			state = SlideStart
		}
		
		if active_time < 0
		{
			state = Deactivating
			cooldown = max_cooldown
		}
		
		break
	case Activating:
		spr = sEShieldActivating
		image_speed = 2
		
		break
	case Deactivating:
		spr = sEShieldDeactivating
		image_speed = 1
		
		break
	case SlideStart:
		cooldown -= .5
		cooldown = clamp(cooldown, 0, max_cooldown)
		
		
		spr = sEShieldActive
		image_speed = 1
		
		break
	case Slide:
		cooldown -= .5
		cooldown = clamp(cooldown, 0, max_cooldown)
		
		spr = sEShieldSlide
		image_speed = 1
		
		break
}

if sprite_index != spr
	sprite_index = spr

#endregion