extends Node

var game_started = true

var max_temperature = 100.0

var overheated = false
var temperature = 10.0
var temperature_growth = 1.0

enum game_states { MENU, CUTSCENE, GAMEPLAY, OVERHEATED, VICTORY }
var gamestate = GAMEPLAY

signal on_overheat


#---------------------------------------------------
func _ready():
	pass
#---------------------------------------------------


#---------------------------------------------------
	
func add_cooling(amount):
	temperature -= amount
	
	if temperature < 0.0:
		temperature = 0.0
	
#---------------------------------------------------

func add_heat(amount):
	temperature += amount
	
#---------------------------------------------------

func _process(delta):
	if game_started and !overheated:
		temperature += delta * temperature_growth
		
		if temperature > max_temperature:
			overheated = true
			gamestate = OVERHEATED
			emit_signal("on_overheat")