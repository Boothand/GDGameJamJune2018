extends "res://Environment/InteractionObjects/InteractionObject.gd"

export var cooling_amount = 7.0
export var heat_event_amount = 20.0

var dog_cooling_timer = 0.0

var danger_zone_threshold = 5.0



#---------------------------------------------------
func _ready():
	._ready()
	pass
#---------------------------------------------------


#---------------------------------------------------

func event_dog_entered(in_dog):
	if !event_has_happened:
		start_roulette_event_routine()
			
#---------------------------------------------------

func event_dog_exited(in_dog):
	pass


#---------------------------------------------------
		
func start_roulette_event_routine():
	
	while dog_cooling_timer < danger_zone_threshold and !event_has_happened:
		yield(get_tree(), "idle_frame")
	
	while true:
			
		randomize()
		var randnum = rand_range(0.0, 100.0)
		
		if randnum > 70.0 - dog_cooling_timer and !event_has_happened:
			initiate_bad_event()
			return
		yield(get_tree().create_timer(2.0), "timeout")

#---------------------------------------------------		

func initiate_bad_event():
	.initiate_bad_event()
	if dog:
		GameManager.add_heat(heat_event_amount)
		GameManager.display_remark("Way to go, dog. Your heat did this.")
		$Particles1.emitting = true
		$Particles2.emitting = true

#---------------------------------------------------

func _process(delta):
	._process(delta)
	
	if dog and !event_has_happened:
		GameManager.add_cooling(delta * cooling_amount)
		dog_cooling_timer += delta
