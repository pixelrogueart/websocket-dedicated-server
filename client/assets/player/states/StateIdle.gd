extends PlayerBaseState

@export var walkPath:NodePath
@onready var walkState = get_node(walkPath)

func enter() -> void:
	super.enter()

func input(event: InputEvent) -> PlayerBaseState:
	var inputDir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_raw_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_raw_strength("move_forward")
		).normalized()
	if inputDir != Vector2.ZERO:
		return walkState
	return null

func physics_process(delta: float) -> PlayerBaseState:
	return null
