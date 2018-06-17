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
	var visible_sprite = $VisibleSpriteParent/IceCubes
	
	
	randomize()
	
	if rand_range(0.0, 1.0) > coolness_bias:
		$Twinkle.get_surface_material(0).albedo_color = Color(1,0,0)
		visible_sprite = $VisibleSpriteParent/Chili
		
		yield(get_tree().create_timer(0.8), "timeout")
		
		if dog:
			GameManager.add_heat(heating_amount)
			GameManager.display_remark("Ow! Fire chilis. Of course")
		else:
			GameManager.display_remark("Nice dodge!")
	else:
		yield(get_tree().create_timer(0.8), "timeout")
		
		if dog:
			GameManager.add_cooling(cooling_amount)
			GameManager.display_remark("Ice cubes. Feels good.")
		else:
			GameManager.display_remark("Gosh darn! You missed the ice cubes.")
		
	visible_sprite.visible = true
	
	yield(get_tree().create_timer(0.5), "timeout")
	$AnimationPlayer.play("Hide The Sprite")
		

#func _process(delta):
#	pass
