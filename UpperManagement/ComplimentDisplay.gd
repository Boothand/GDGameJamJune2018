extends Label



func _ready():
	GameManager.connect("on_display_remark", self, "_handle_display_remark")
	pass

func _handle_display_remark(remark):
	text = remark
	$AnimationPlayer.play("Display Remark")
	print("Label")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
