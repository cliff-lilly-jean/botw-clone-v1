extends SpringArm3D

@export var min_limit_x : float
@export var max_limit_x : float
@export var horizontal_acceleration : float = 2.0
@export var vertical_acceleration : float = 1.0
@export var mouse_acceleration: float = 0.005
@export var spring_arm_length : float = 6.5

func _ready() -> void:
	spring_length = spring_arm_length

func _process(delta: float) -> void:
	
	# input vector for joystick 
	var joy_dir = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	
	# rotate the joystick vector
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * mouse_acceleration)
		

func rotate_from_vector(v: Vector2) -> void:
	if v.length() == 0 : return
	
	# rotate horizontally along the y axis
	rotation.y -= v.x
	
	# rotate vertically along the x axis and clamp the rotation
	rotation.x -= v.y
	rotation.x = clampf(rotation.x, min_limit_x, max_limit_x)
