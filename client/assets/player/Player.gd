class_name Player
extends CharacterBody2D

@onready var animations = $Animations
@onready var states = $StateManager
@onready var traits = $Traits
@onready var angleMovement = $AngleMovement
@onready var terrainDetector = $TerrainDetector
var controlling = true
var playerState = {}

func _ready() -> void:
	GlobalValues.player = self
	GlobalSignals.connect("CHANGE_PLAYER_STATE",change_player_state)
	GlobalSignals.connect("CHANGE_PLAYER_CONTROL_STATE",change_player_control_state)
	GlobalSignals.connect("LOAD_PLAYER_STATE",load_player_state)
	states.init(self)
	change_player_state(false)

func change_player_state(value):
	set_process_unhandled_input(value)
	set_process(value)
	set_physics_process(value)
	set_process_input(value)

func change_player_control_state(value):
	controlling = value

func load_player_state(state):
	if state:
		if "P" in state:
			self.global_position = GlobalFunctions.string_to_vector2(state["P"])
		if "D" in state:
			traits.currentDirection = state["D"][0]
			traits.flip_sprite(state["D"][1])
	$Tooltip.tooltip_text = Database.username
	

func _unhandled_input(event: InputEvent) -> void:
	if controlling:
		states.input(event)
	
func _physics_process(delta: float) -> void:
	if controlling:
		states.physics_process(delta)

func _process(delta: float) -> void:
	if Server.connected:
		define_player_state()
	if controlling:
		states.process(delta)

func move(moveSpeed):
	var inputDir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_raw_strength("move_left"),
		Input.get_action_strength("move_backward") - Input.get_action_raw_strength("move_forward")
		).normalized()
	velocity = inputDir * moveSpeed
	if inputDir != Vector2.ZERO:
		angleMovement.rotation = inputDir.angle()
	traits.verify_direction()
	move_and_slide()
	return inputDir

func define_player_state():
	playerState = {"T": Time.get_unix_time_from_system(),"P": self.global_position, "A": animations.current_animation, "D": [traits.currentDirection, traits.flip, traits.traits]}
	Server.broadcast("receivePlayerState",playerState)
