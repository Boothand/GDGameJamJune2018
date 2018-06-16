extends AnimationTreePlayer

export var movement_blend_speed = 2.0

var dog = null
var movement_value = 0.0

func _ready():
	dog = get_parent()
	pass

func _process(delta):
	var movement_target_value = 0.0
	if dog:
		if dog.moving:
			movement_target_value = 1.0
			
	movement_value = lerp(movement_value, movement_target_value, delta * movement_blend_speed)
	
	blend2_node_set_amount("idle_walk_blend", movement_value)
		
	pass
