extends KinematicBody

export var move_speed = 1.0
export var movement_responsiveness = 5.0
export var jump_force = 4.0
export var turnaround_threshold = 0.1
export var turnaround_speed = 5.0

var velocity = Vector3()
var x_input = 0.0
var moving = false
var on_ground = false
var target_rot = 0.0
var crouching = false

signal on_jump
signal on_crouch_begin
signal on_crouch_end


#---------------------------------------------------
func _ready():
	$AnimationTreePlayer.active = true
	GameManager.connect("on_overheat", self, "_handle_overheat")
	pass
#---------------------------------------------------



#---------------------------------------------------
	
func input_move(x_direction):
	x_input = clamp(x_direction, -1.0, 1.0)
	
#---------------------------------------------------

func input_jump():
	if is_on_floor():
		velocity.y += jump_force
		emit_signal("on_jump")

#---------------------------------------------------

func input_crouch(crouch):
	if !crouching and crouch:
		emit_signal("on_crouch_begin")
	if crouching and !crouch:
		emit_signal("on_crouch_end")
		
	crouching = crouch

#---------------------------------------------------

func _handle_overheat():
	print("Dog overheated")
	
#---------------------------------------------------

func _physics_process(delta):
	# Some damp
	velocity *= 0.99
	
	move_and_slide(velocity, Vector3(0.0, 1.0, 0.0))

#---------------------------------------------------

func _process(delta):
	# Falling:
	velocity += Vector3(0.0, -9.81 * delta, 0.0)
	
	# Moving sideways
	velocity.x = lerp(velocity.x, x_input * move_speed, delta * movement_responsiveness)
	
	moving = abs(x_input) > 0.0
	
	# Check for collisions:
	if is_on_floor():
		velocity.y = -0.1
	
	# Turning around
	if velocity.x > turnaround_threshold:
		target_rot = 0.0
	elif velocity.x < -turnaround_threshold:
		target_rot = 180.0
		
	$Spatial.rotation_degrees.y = lerp($Spatial.rotation_degrees.y, target_rot, delta * turnaround_speed)
	
	