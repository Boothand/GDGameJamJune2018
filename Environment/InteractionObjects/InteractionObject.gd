extends Spatial

var dog = null
signal on_event_happened
var event_has_happened = false


#---------------------------------------------------
func _ready():
	$Area.connect("body_entered", self, "_handle_body_entered")
	$Area.connect("body_exited", self, "_handle_body_exited")
	pass
#---------------------------------------------------
	

func _handle_body_entered(other_obj):
	if other_obj.is_in_group("Dog"):
		dog = other_obj
		event_dog_entered(other_obj)
			
#---------------------------------------------------
		
func _handle_body_exited(other_obj):
	if other_obj.is_in_group("Dog"):
		dog = null
		print("ok")
		event_dog_exited(other_obj)

#---------------------------------------------------

func initiate_bad_event():
		event_has_happened = true
		emit_signal("on_event_happened")

func event_dog_entered(in_dog):
	pass
	
func event_dog_exited(in_dog):
	pass

func start_roulette_event_routine():
	pass

func _process(delta):
	pass
