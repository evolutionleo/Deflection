/// @desc
kapp = "Hi world lol"
pepe = 1

setTimeout(self, function(){ show_debug_message(kapp) }, 10, {pers: false})

setInterval(self, function() { show_debug_message(++pepe) }, 15)