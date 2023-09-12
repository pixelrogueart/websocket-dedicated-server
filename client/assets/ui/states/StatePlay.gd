extends BaseState

func enter() -> void:
	$"../../Background".hide()
	await get_tree().create_timer(5).timeout
	super.enter()
	
func exit() -> void:
	$"../../Background".show()
	super.exit()

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("chat"):
		if !screenNode.textInput.has_focus():
			GlobalSignals.emit_signal("CHANGE_PLAYER_CONTROL_STATE",false)
			screenNode.tip.hide()
			screenNode.textInput.grab_focus()
#			screenNode.textInput.show()
			screenNode.animations.play("show_chat")
	return null

func physics_process(delta: float) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

