extends "res://Environment/InteractionObjects/InteractionObject.gd"

export var cooling_amount = 1.8
export var heat_event_amount = 20.0

var dog_cooling_timer = 0.0

var danger_zone_threshold = 5.0

var bee_attacking = false

#---------------------------------------------------
func _ready():
	._ready()
	
	$Wasp/Area.connect("body_entered", self, "_handle_bee_body_entered")
	
	pass
#---------------------------------------------------


#---------------------------------------------------

func event_dog_entered(in_dog):
	if !event_has_happened:
		start_roulette_event_routine()
			
#---------------------------------------------------
		
func _handle_body_exited(other_obj):
	pass

#---------------------------------------------------
		
func start_roulette_event_routine():
	
	while dog_cooling_timer < danger_zone_threshold:
		yield(get_tree(), "idle_frame")
		
	if !dog:
		return
	
	while true:
		
		randomize()
		var randnum = rand_range(0.0, 100.0)
		
		if randnum > 50.0 - dog_cooling_timer:
			initiate_bad_event()
			return
		yield(get_tree().create_timer(2.0), "timeout")

#---------------------------------------------------		

func initiate_bad_event():
	.initiate_bad_event()
	
	$AnimationPlayer.play("Bee Attack")

#---------------------------------------------------

func set_bee_attacking(attacking):
	bee_attacking = attacking
	
#---------------------------------------------------

func _handle_bee_body_entered(other_body):
	if other_body.is_in_group("Dog") and bee_attacking:
		print("Stung da dog!")
		GameManager.add_heat(heat_event_amount)

#---------------------------------------------------


func _process(delta):
	._process(delta)
	
	if dog and !event_has_happened:
		GameManager.add_cooling(delta * cooling_amount)
		dog_cooling_timer += delta