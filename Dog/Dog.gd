extends KinematicBody

export var move_speed = 150.0
export var movement_responsiveness = 5.0
export var jump_force = 500.0
export var turnaround_threshold = 1.0

var velocity = Vector3()
var x_input = 0.0
var moving = false
var on_ground = false


#---------------------------------------------------
func _ready():
	$AnimationTreePlayer.active = true
	pass
#---------------------------------------------------



#---------------------------------------------------
	
func input_move(x_direction):
	x_input = clamp(x_direction, -1.0, 1.0)
	
#---------------------------------------------------

func input_jump():
	if on_ground:
		velocity.y -= jump_force

#---------------------------------------------------

func _physics_process(delta):
	velocity *= 0.99
#	move_and_slide(velocity, Vector2(-1.0, 0.0))
	move_and_slide(velocity, Vector3(0.0, 1.0, 0.0))
	
	pass

#---------------------------------------------------

func _process(delta):
	# Falling:
	velocity += Vector3(0.0, -981 * delta, 0.0)
	
	# Moving sideways
	velocity.x = lerp(velocity.x, x_input * move_speed, delta * movement_responsiveness)
	
	moving = abs(x_input) > 0.0
	
	# Check for collisions:
	var collision_info = get_slide_collision(0)
	on_ground = false
	if collision_info:
		# Prevent velocity.y from decreasing to the abyss and beyond
		velocity.y = 0.0
		on_ground = true
	
	# Turning around
	if velocity.x > turnaround_threshold:
		$Dog_Root.scale.x = 1.0
	elif velocity.x < -turnaround_threshold:
		$Dog_Root.scale.x = -1.0
	
	