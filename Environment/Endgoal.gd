extends MeshInstance

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var found_dog = false

func _ready():
	$Area.connect("body_entered", self, "_handle_body_entered")
	pass
	
func _handle_body_entered(body):
	if body.is_in_group("Dog") and !found_dog:
		found_dog = true
		GameManager.finish_level()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
