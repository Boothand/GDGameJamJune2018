extends MeshInstance

export var rotate_speed = 1.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AnimationPlayer.play("SunShakyIdle")
	pass

func _process(delta):
	$MeshInstance.rotate_z(delta * rotate_speed)
	$MeshInstance2.rotate_z(delta * -rotate_speed)
	pass
