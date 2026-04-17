extends Node3D

@onready var movement_state_machine = $AnimationTree.get("parameters/playback")


func set_movement_state(state : String) -> void:
	movement_state_machine.travel(state)
