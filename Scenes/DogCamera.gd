extends Camera

export var right_edge_threshold = 0.2
export var left_edge_threshold = 0.15
export var skip_interval = 3.0

export var camera_stiffness = 2.0

var targetpos = Vector3()




export(NodePath) var target

#---------------------------------------------------
func _ready():
#	dog = get_tree().get_nodes_in_group("Dog")[0]
	targetpos = transform.origin
	target = get_node(target)
#---------------------------------------------------



func _process(delta):
	if target:
		var target_screenpos = unproject_position(target.global_transform.origin) / get_viewport().size
		
		if target_screenpos.x > 1.0 - right_edge_threshold:
			targetpos.x += skip_interval
		elif target_screenpos.x < right_edge_threshold:
			targetpos.x -= skip_interval
			
	transform.origin = transform.origin.linear_interpolate(targetpos, delta * camera_stiffness)
