class_name BaseState
extends Node

@export var enter_animation:String
@export var exit_animation:String
@export var screenPath:NodePath
# Pass in a reference to the player's kinematic body so that it can be used by the state
var gui: GUI
var screenNode


func _ready():
	screenNode = get_node(screenPath)

func enter() -> void:
	screenNode.show()
	gui.animations.play(enter_animation)

func exit() -> void:
	screenNode.hide()
	gui.animations.play(exit_animation)

func input(event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
