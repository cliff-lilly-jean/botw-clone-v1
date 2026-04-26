extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var movement_state_machine = animation_tree.get("parameters/MoveStateMachine/playback")

var attacking: bool = false

func set_movement_state(state : String) -> void:
	movement_state_machine.travel(state)

func attack() -> void:
	if not attacking:
		animation_tree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func attack_toggle(value: bool) -> void:
	attacking = value
	print(attacking)
