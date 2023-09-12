extends BaseState


func enter() -> void:
	screenNode.wordInput.grab_focus()
	super.enter()

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("cancel"):
		Server.leave_matchmaking()
		GlobalSignals.emit_signal("CHANGE_SCREEN","Connect")
		pass
	return null

func physics_process(delta: float) -> BaseState:
	return null
