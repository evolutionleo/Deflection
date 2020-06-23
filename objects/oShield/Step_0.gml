/// @desc

var radius = 18

var target_x = mouse_x
var target_y = mouse_y

var target_dir = point_direction(oPlayer.x, oPlayer.y, target_x, target_y)
var diff = angle_difference(image_angle, target_dir)


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
		
		active_time++
		
		if active_time > max_active_time
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
}

if sprite_index != spr
	sprite_index = spr