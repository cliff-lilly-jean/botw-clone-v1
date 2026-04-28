extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var second_attack_timer: Timer = $SecondAttackTimer

@onready var movement_state_machine = animation_tree.get("parameters/MoveStateMachine/playback")
@onready var attack_state_machine = animation_tree.get("parameters/AttackStateMachine/playback")

var attacking: bool = false

func set_movement_state(state : String) -> void:
	movement_state_machine.travel(state)

func attack() -> void:
	if not attacking:
		attack_state_machine.travel('Slice' if second_attack_timer.time_left else 'Chop')
		animation_tree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func attack_toggle(value: bool) -> void:
	attacking = value
