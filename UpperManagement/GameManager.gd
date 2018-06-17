extends Node

var game_started = true

var max_temperature = 100.0

var overheated = false
var temperature = 0.0
var temperature_growth = 0.5

enum game_state { MENU, CUTSCENE, GAMEPLAY, OVERHEATED, VICTORY }

signal on_overheat


#---------------------------------------------------
func _ready():
	pass
#---------------------------------------------------


#---------------------------------------------------
	
func add_cooling(amount):
	temperature -= amount
	
#---------------------------------------------------

func _process(delta):
	if game_started and !overheated:
		temperature += delta * temperature_growth
		
		if temperature > max_temperature:
			overheated = true
			game_state = OVERHEATED
			emit_signal("on_overheat")