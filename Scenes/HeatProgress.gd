extends TextureProgress

export var grow_rate = 0.5

var overheated = false
signal on_overheat

func _ready():
	pass

func _process(delta):
	value += delta * grow_rate
	
	if value >= 100.0 and !overheated:
		overheated = true
		emit_signal("on_overheat")
	pass