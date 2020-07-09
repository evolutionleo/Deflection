/// @desc
#region State

#macro Inactive 20
#macro Deactivating 21
#macro Activating 22
#macro Active 23
#macro SlideStart 24
#macro Slide 25

state = Inactive


parried = 0

active_time = 0 //Remaining
max_active_time = 20
real_max_active_time = 40

cooldown = 0
max_cooldown = 60

#endregion
#region Input

Input = require("input")
Input.addBind("parry", mb_left-100)
Input.addBind("parry", gp_shoulderrb+100)

#endregion
#region Position

pos = new Vector2(x, y)
radius = 18


image_xscale = 1.5
image_yscale = 1.5

#endregion