class_name Peer
extends CharacterBody2D

@onready var animations = $Animations
@onready var traits = $Traits
@onready var speechBoxLabel = $SpeechBoxLabel

#Whatever you send to the server via the Player.gd - define_player_state(), gets replicated here to other peers.
func update_state(pos,animation,dir):
	pos = GlobalFunctions.string_to_vector2(pos)
	self.global_position = pos
	if animation != animations.current_animation:
		animations.play(animation)
	traits.currentDirection = dir[0]
	traits.flip_sprite(dir[1])
	traits.traits = dir[2]

