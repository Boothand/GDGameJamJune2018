extends Node


var max_temperature = 100.0

var overheated = false
var temperature = 10.0
var temperature_growth = 1.0

enum game_states { MENU, CUTSCENE, GAMEPLAY, OVERHEATED, VICTORY }
var gamestate = MENU

signal on_overheat

signal on_display_remark
signal fade_to_black
signal fade_to_transparent

signal on_paused
signal on_resumed

#---------------------------------------------------
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass
#---------------------------------------------------

func start_gameplay():
	gamestate = GAMEPLAY

#---------------------------------------------------

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		emit_signal("on_paused")
	else:
		emit_signal("on_resumed")
	
#---------------------------------------------------
	
func add_cooling(amount):
	temperature -= amount
	
	if temperature < 0.0:
		temperature = 0.0
	
#---------------------------------------------------

func add_heat(amount):
	temperature += amount
	
#---------------------------------------------------

func display_remark(remark):
	emit_signal("on_display_remark", remark)
	
#---------------------------------------------------

func _input(event):
	if gamestate == GAMEPLAY and event.is_action_pressed("pause"):
		GameManager.toggle_pause()

#---------------------------------------------------


func _process(delta):
	if gamestate == GAMEPLAY and !overheated and !get_tree().paused:
		temperature += delta * temperature_growth
		
		if temperature > max_temperature:
			overheated = true
			gamestate = OVERHEATED
			emit_signal("on_overheat")
			
			yield(get_tree().create_timer(3.0), "timeout")
			emit_signal("fade_to_black")