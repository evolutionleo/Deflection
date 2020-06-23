/// @desc
var msg = event_data[? "message"]

if in_sequence
{
	switch(msg)
	{
		case "1_1 Shoot":
			stuck = oReflection
			bullet_type = oGhostBullet
			//lock_on = true
			active = true
			stopInterval(int)
			
			dir = point_direction(x, y, oPlayer.x, oPlayer.y) + random_range(-1, 1)
			
			props = {owner: oReflection}
			shoot()
			break
		case "1_1 Destroy":
			instance_destroy(self, false)
			break
		case "1_2 Destroy":
			instance_destroy(self, false)
			break
		case "1_3 Destroy":
			instance_destroy(self, false)
			break
		case "1_2 Shoot":
			bullet_type = oBouncyGhostBullet
			active = true
			dir = 180
			stopInterval(int)
			
			props = {image_xscale: 2, image_yscale: 2, owner: oReflection}
			shoot()
			
			//instance_destroy()
			break
		case "1_3 Shoot":
			if(distance_to_object(oReflection_copy) < 64)
			{
				bullet_type = oGhostBullet
				active = true
				dir = point_direction(x, y, oPlayer.x, oPlayer.y) + random_range(-5, 5)
				stopInterval(int)
			
				props = {image_xscale: 1.5, image_yscale: 1.5, owner: oReflection}
				shoot()
			
				//instance_destroy()
			}
			break
	}
}