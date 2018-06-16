extends Node

var dog

func _ready():
	dog = get_parent()
	pass

func _process(delta):
	var x_input = 0.0
	
	if dog:
		if Input.is_action_pressed("ui_right"):
			x_input += 1.0
		elif Input.is_action_pressed("ui_left"):
			x_input -= 1.0
			
		dog.input_move(x_input)
		
		if Input.is_action_just_pressed("ui_up"):
			dog.input_jump()
		
		dog.input_crouch(Input.is_action_pressed("ui_down"))
