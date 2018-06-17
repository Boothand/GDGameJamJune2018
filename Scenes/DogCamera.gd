extends Camera

var dog = null

func _ready():
	dog = get_tree().get_nodes_in_group("Dog")[0]
	pass

func _process(delta):
	if dog:
		var dog_screenpos = unproject_position(dog.global_transform.origin)
		print(dog_screenpos / get_viewport().size)
	pass
