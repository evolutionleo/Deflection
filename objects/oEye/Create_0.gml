/// @desc

event_inherited()

#region Procedural animation

#macro FIXED 0

var m = ds_map_create()
m[? Idle] = [0, 0]
m[? Walk] = [5, "move_x"]
m[? Chasing] = [5, "player"]
m[? AttackStart] = [5, "fixed"]
//m[? Attack] = [0, 0] // Custom
m[? AttackEnd] = [0, 0]


positions = m


state = Idle
//state = Chasing

sprite_index = sEye
pupil_sprite = sPupil

pupil_pos = new Vector2(x, y)
target_pos = new Vector2(x, y)

fixed_position = false

#endregion
#region Gameplay!

attacks = [
	[	//Phase 1
		{pos: [5, "player"], timeline: tEyeAttack1_1, rec: 180},
		{pos: [0, 0], timeline: tEyeAttack1_2, rec: 180},
		{pos: [3, "player"], timeline: tEyeAttack1_3, rec: 120}
	],
	[	//Phase 2
		{pos: [5, "player"], timeline: tEyeAttack2_1, rec: 90},
		{pos: [0.5, "player"], timeline: tEyeAttack2_2, rec: 90},
		{pos: [7, "player"], timeline: tEyeAttack2_3, rec: 90}
	]
]

phases = [100, 40]

attack = 1
prev_attack = attack

attack_struct = {}

laser = noone

def = hb_add(id,"def",hEye_def)
atk = hb_add(id,"atk",hEye_atk)

#endregion
#region Warning
if !oPlayer.upgrades.Exists("Shield")
{
	state = Idle
	
	setTimeout(self, function() {
		create_text({text: "Hey! You're not supposed\nto be here!", font: fPixel, y: y-128, fade_offset: 80, lifetime: 90})
	}, 30)
	setTimeout(self, function() {
		create_text({text: "Go get shield!", font: fPixel, y: y-128, fade_offset: 80, lifetime: 90})
	}, 120)
	setTimeout(self, function() {
		create_text({text: "Now, DIE!!!", font: fPixel, y: y-128, fade_offset: 80, lifetime: 90})
	}, 210)
	setTimeout(self, function() {
		oPlayer.hit(999)
	}, 260)
}
#endregion
else {
	setTimeout(id, function() {
		setAttack()
		startAttack()
	}, 120)
}