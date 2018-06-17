extends "res://Environment/InteractionObjects/InteractionObject.gd"

export var cooling_amount = 20.0
export var heating_amount = 20.0

var coolness_bias = 0.5

func _ready():
	._ready()
	pass
	
func event_dog_entered(in_dog):
	if !event_has_happened:
		start_roulette_event_routine()
	
func event_dog_exited(in_dog):
	pass

func start_roulette_event_routine():
	$AnimationPlayer.play("Open chest")
	event_has_happened = true
	
	
func set_content_type_random():
	var ice_content = true
	$Twinkle.get_surface_material(0).albedo_color = Color(0.5,0.5,1)
	
	randomize()
	if rand_range(0.0, 1.0) > coolness_bias:
		$Twinkle.get_surface_material(0).albedo_color = Color(1,0,0)
		yield(get_tree().create_timer(0.8), "timeout")
		
		if dog:
			GameManager.add_heat(heating_amount)
		else:
			print("Nice dodge!")
	else:
		yield(get_tree().create_timer(0.8), "timeout")
		
		if dog:
			GameManager.add_cooling(cooling_amount)
		

#func _process(delta):
#	pass
