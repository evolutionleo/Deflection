/// @desc

iframes--

if !iframes and distance_to_object(oPlayer) < 32 and hb_meeting(atk, oPlayer.def) and oPlayer.state != ShieldSlide
{
	oPlayer.hit(1)
	iframes = max_iframes
}