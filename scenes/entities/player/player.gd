extends CharacterBody3D

# jump
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_decent : float = 0.3

@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_decent * jump_time_to_decent)) * -1.0

# movment
@export var base_speed : float = 6.0
@export var run_speed :  float = 20.0
var movement_input : Vector2 = Vector2.ZERO

# camera
@onready var camera = $CameraController/Camera3D


func _physics_process(delta: float) -> void:
	
	move(delta)
	jump(delta)
	
	move_and_slide()

# movement logic			
func move(delta: float) -> void:
	# get the input direction and convert it to a velocity
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	
	var current_velocity = Vector2(velocity.x, velocity.z)
	var is_running = Input.is_action_pressed("run")
	var speed = run_speed if is_running else base_speed
	
	var target_velocity = movement_input * speed
	
	# determine what to do if there is or isn't movement
	if movement_input != Vector2.ZERO:
		current_velocity = current_velocity.move_toward(target_velocity, 40.0 * delta)
		$PeasantSkin.set_movement_state("Sprint")
		var target_angle = -movement_input.angle() + PI/2 # negative the movement angle multiplied by PI/2 to get the correct rotation based off camera rotation
		$PeasantSkin.rotation.y = rotate_toward($PeasantSkin.rotation.y, target_angle, 20.0 * delta)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, 120.0 * delta)
		$PeasantSkin.set_movement_state("Idle")
	
	velocity.x = current_velocity.x
	velocity.z = current_velocity.y

	
# jump logic
func jump(delta: float) -> void:
	
	# determine if able to jump
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity
			#$PeasantSkin.set_movement_state("Jump")
			
	# apply gravity
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
