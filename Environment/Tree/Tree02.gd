extends "res://Environment/InteractionObjects/InteractionObject.gd"

export var cooling_amount = 2.0
export var heat_event_amount = 20.0

var dog_cooling_timer = 0.0

var danger_zone_threshold = 5.0

var bee_attacking = false

var dog_stung = false

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
		
func start_roulette_event_routine():
	
	while dog_cooling_timer < danger_zone_threshold and !event_has_happened:
		yield(get_tree(), "idle_frame")
	
	while true and !event_has_happened:
		
		randomize()
		var randnum = rand_range(0.0, 100.0)
		
		if randnum > 50.0 - dog_cooling_timer:
			initiate_bad_event()
			return
		yield(get_tree().create_timer(2.0), "timeout")

#---------------------------------------------------		

func initiate_bad_event():
	.initiate_bad_event()
	if dog:
		$AnimationPlayer.play("Bee Attack")
	
	
	yield($AnimationPlayer, "animation_finished")
	
	if !dog_stung:
		GameManager.display_remark("So you didn't get stung by the bee. Good for you, dog.")

#---------------------------------------------------

func set_bee_attacking(attacking):
	bee_attacking = attacking
	
#---------------------------------------------------

func _handle_bee_body_entered(other_body):
	if other_body.is_in_group("Dog") and bee_attacking:
		dog_stung = true
		GameManager.display_remark("Stung by a fire bee?! What a goofdog.")
		GameManager.add_heat(heat_event_amount)

#---------------------------------------------------


func _process(delta):
	._process(delta)
	
	if dog and !event_has_happened:
		GameManager.add_cooling(delta * cooling_amount)
		dog_cooling_timer += delta
