extends Panel



#---------------------------------------------------
func _ready():
	GameManager.connect("fade_to_black", self, "_handle_fade_to_black")
	GameManager.connect("fade_to_transparent", self, "_handle_fade_to_transparent")
	
	modulate.a = 1.0
	yield(get_tree().create_timer(0.4), "timeout")
	fade_to_transparent()
#---------------------------------------------------
	
	
#---------------------------------------------------

func _handle_fade_to_black():
	fade_to_black()

#---------------------------------------------------

func _handle_fade_to_transparent():
	fade_to_transparent()
	
#---------------------------------------------------

func fade_to_alpha(new_alpha):
	var current_alpha = modulate.a
	var timer = 0.0
	var duration = 1.0
	
	while timer < duration:
		timer += get_process_delta_time()
		
		modulate.a = lerp(current_alpha, new_alpha, timer / duration)
		yield(get_tree(), "idle_frame")

#---------------------------------------------------

func fade_to_transparent():
	fade_to_alpha(0.0)

#---------------------------------------------------

func fade_to_black():
	fade_to_alpha(1.0)

#---------------------------------------------------

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
