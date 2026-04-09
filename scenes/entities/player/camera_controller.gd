extends Node3D

@export var horizontal_acceleration : float = 2.0
@export var vertical_acceleration : float = 1.0

func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * 0.05)
		

func rotate_from_vector(v: Vector2) -> void:
	if v.length() == 0 : return
	rotation.y += v.x
	rotation.x += v.y
	rotation.x = clampf(rotation.x, -0.8, 0.1)
