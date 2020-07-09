/// @desc

instance_add_flag(self, SOLID)
instance_add_flag(self, MOVING)


spd = new Vector2(0, 0)
pos = new Vector2(x, y)
dir = new Vector2(0, 0)

prev_spd = new Vector2(0, 0)

momentum_delay = 0
max_momentum_delay = 10

#macro Forward 1
#macro Backwards 2

state = Inactive


playerDir = undefined