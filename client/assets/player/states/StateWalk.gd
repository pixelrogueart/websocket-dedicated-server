extends PlayerBaseState

@export var idlePath:NodePath
@onready var idleState = get_node(idlePath)

@export var moveSpeed:int = 5

@onready var timer = $Timer
@export var footstepDelay = 0.3

func enter() -> void:
	timer.start(footstepDelay)
	_on_timer_timeout()
	super.enter()

func input(event: InputEvent) -> PlayerBaseState:
	return null

func physics_process(delta: float) -> PlayerBaseState:
	var inputDir = player.move(moveSpeed)
	if inputDir == Vector2.ZERO:
		return idleState
	return null

func exit() -> void:
	timer.stop()

func _on_timer_timeout():
	Server.request_play_audio(player.terrainDetector.standingTile,player.global_position)
	timer.start(footstepDelay)
