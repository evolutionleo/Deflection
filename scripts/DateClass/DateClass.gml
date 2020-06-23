function Date() constructor {
	second = current_second
	minute = current_minute
	hour = current_hour
	day = current_day
	month = current_month
	year = current_year
	
	weekday = current_weekday
	
	toString = function() {
		return string(hour)+":"+string(minute)+":"+string(second)+" "+string(day)+"."+string(month)+"."+string(year)
	}
	
	getYear = function() { return year }
	getMonth = function() { return month }
	getDay = function() { return day }
	getHour = function() { return hour }
	getMinute = function() { return minute }
	getSecond = function() { return second }
	getWeekday = function() { return weekay }
}