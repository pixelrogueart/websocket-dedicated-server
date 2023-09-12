extends Control
@onready var textInput = $TextInput
@onready var animations = $Animation
@onready var tip = $Tip
func _on_text_input_text_submitted(new_text):
	if new_text != "":
		Server.send_text(new_text,$"../..".player.global_position)
		GlobalSignals.emit_signal("SEND_TEXT",new_text)
		textInput.text = ""
		textInput.release_focus()
		GlobalSignals.emit_signal("CHANGE_PLAYER_CONTROL_STATE",true)
		animations.play("hide_chat")
		tip.show()
	else:
		GlobalSignals.emit_signal("CHANGE_PLAYER_CONTROL_STATE",true)
		textInput.release_focus()
		animations.play("hide_chat")
		tip.show()

