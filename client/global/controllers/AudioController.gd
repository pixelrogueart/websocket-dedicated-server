extends Node

@onready var audioPlayer = preload("./AudioPlayer.tscn")

var audioLibrary = {
	"footstep_concrete": ["res://sound/sfx/footstep_concrete (1).wav", "res://sound/sfx/footstep_concrete (2).wav", "res://sound/sfx/footstep_concrete (3).wav", "res://sound/sfx/footstep_concrete (4).wav", "res://sound/sfx/footstep_concrete (5).wav", "res://sound/sfx/footstep_concrete (6).wav", "res://sound/sfx/footstep_concrete (7).wav", "res://sound/sfx/footstep_concrete (8).wav", "res://sound/sfx/footstep_concrete (9).wav"],
	"footstep_grass": ["res://sound/sfx/footstep_grass (1).wav", "res://sound/sfx/footstep_grass (2).wav", "res://sound/sfx/footstep_grass (3).wav", "res://sound/sfx/footstep_grass (4).wav", "res://sound/sfx/footstep_grass (5).wav", "res://sound/sfx/footstep_grass (6).wav", "res://sound/sfx/footstep_grass (7).wav", "res://sound/sfx/footstep_grass (8).wav", "res://sound/sfx/footstep_grass (9).wav", "res://sound/sfx/footstep_grass (10).wav"],
	"gibberish": ["res://sound/sfx/gibberish (1).wav", "res://sound/sfx/gibberish (2).wav", "res://sound/sfx/gibberish (3).wav", "res://sound/sfx/gibberish (4).wav", "res://sound/sfx/gibberish (5).wav", "res://sound/sfx/gibberish (6).wav", "res://sound/sfx/gibberish (7).wav"],
}

func _ready():
	randomize()

func play_audio(sfx,pos,index = null):
	var newAudioPlayer = audioPlayer.instantiate()
	if index:
		newAudioPlayer.stream = load(audioLibrary[sfx][index])
	else:
		newAudioPlayer.stream = load(audioLibrary[sfx][randi()%audioLibrary[sfx].size()])
	if pos is String:
		pos = GlobalFunctions.string_to_vector2(pos)
	newAudioPlayer.global_position = pos
	self.add_child(newAudioPlayer)
