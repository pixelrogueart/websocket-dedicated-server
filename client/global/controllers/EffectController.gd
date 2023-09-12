extends Node

@onready var fxPlayer = preload("./EffectPlayer.tscn")

var audioLibrary = {
	"pop": [],
}

func _ready():
	randomize()

func play_fx(pos,parent):
	var newFxPlayer = fxPlayer.instantiate()
	newFxPlayer.global_position = pos
	parent.add_child(newFxPlayer)
