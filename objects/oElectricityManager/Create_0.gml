/// @desc
Power = new Array()
ConstPower = new Array()

powerEvents = new Array()


__updateSignal = function() {
	if powerEvents.Empty()
		return 0
	
	powerEvents.ForEach(function(powerEvent, ch) {
		if powerEvent == 0 {}
		else {
			if Power.Size - 1 < ch
				Power.Set(ch, 0)
			
			powerEvent.Fire(Power.Get(ch))
		}
	})
}


//powerEvents.SetHandler(ERROR_HANDLER_CONSOLE)