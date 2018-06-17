extends AnimationTreePlayer

export var movement_blend_speed = 2.0
export var crouch_blend_speed = 5.0

var dog = null
var movement_value = 0.0
var crouch_value = 0.0


#---------------------------------------------------
func _ready():
	dog = get_parent()
	dog.connect("on_jump", self, "_handle_jump")
	dog.connect("on_crouch_begin", self, "_handle_crouch_begin")
	dog.connect("on_crouch_end", self, "_handle_crouch_end")
#---------------------------------------------------


#---------------------------------------------------

func _handle_jump():
	oneshot_node_start("oneshot_jump")
	
#---------------------------------------------------

func _handle_crouch_begin():
	pass

#---------------------------------------------------
	
func _handle_crouch_end():
	pass
	
#---------------------------------------------------

func _process(delta):
	var movement_target_value = 0.0
	var crouch_target_value = 0.0
	
	if dog:
		if dog.moving:
			movement_target_value = 1.0
			
		if dog.crouching:
			crouch_target_value = 1.0
			
	movement_value = lerp(movement_value, movement_target_value, delta * movement_blend_speed)
	blend2_node_set_amount("idle_walk_blend", movement_value)
	
	crouch_value = lerp(crouch_value, crouch_target_value, delta * crouch_blend_speed)
	blend2_node_set_amount("crouch_blend", crouch_value)
	blend2_node_set_amount("crouchwalk_blend", movement_value)