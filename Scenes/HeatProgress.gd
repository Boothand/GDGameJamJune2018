extends TextureProgress

#---------------------------------------------------
func _ready():
	max_value = GameManager.max_temperature
	pass
#---------------------------------------------------



func _process(delta):
	value = lerp(value, GameManager.temperature, delta * 8.0)
	
	pass