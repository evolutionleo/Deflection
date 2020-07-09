/// @desc
if room == rFirstMap
{
	time = (current_time - offset) div 1000


	msecs = floor(current_time) % 1000
	secs = time % 60
	mins = time div 60 % 60
	hours = time div 3600 % 100


	msecs =	formatTime(msecs, 3)
	secs =	formatTime(secs, 2)
	mins =	formatTime(mins, 2)
	hours =	formatTime(hours, 3)

	str = hours+":"+mins+":"+secs+"."+msecs

}