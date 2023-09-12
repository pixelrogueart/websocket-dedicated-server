class_name PlayerBaseState
extends Node

@export var animation:String

# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player

func enter() -> void:
	player.animations.play(animation)

func exit() -> void:
	pass
func input(event: InputEvent) -> PlayerBaseState:
	return null

func process(delta: float) -> PlayerBaseState:
	return null

func physics_process(delta: float) -> PlayerBaseState:
	return null
