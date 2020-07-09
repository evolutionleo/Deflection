///@desc Create the laser
laser = instance_create_layer(x, y, "Bullets", oLaser)
//laser.dir = pdir(x, y, oPlayer.x, oPlayer.y)
laser.dir = pdir(x, y, pupil_pos.x, pupil_pos.y)

fixed_position = true
//laser.fire()