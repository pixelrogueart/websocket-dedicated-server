extends Control

@onready var userInput = $Panel/UserInput
@onready var passwordInput = $Panel/PasswordInput
@onready var emailInput = $Panel/EmailInput

func _process(delta):
	pass

func _on_cancel_button_pressed():
	GlobalSignals.emit_signal("CHANGE_SCREEN","Menu")

func _on_register_button_pressed():
	Database.register(userInput.text,passwordInput.text,emailInput.text)
	userInput.text = ""
	passwordInput.text = ""

func _on_password_input_text_submitted(new_text):
	if new_text != "":
		if new_text.length() >= 6:
			Database.register(userInput.text,passwordInput.text,emailInput.text)
		else:
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Password needs at least 6 characters...")
	else:
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Password not filled...")

func _on_user_input_text_submitted(new_text):
	if new_text != "":
		if new_text.length() >= 4:
			Database.register(userInput.text,passwordInput.text,emailInput.text)
		else:
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Username needs at least 4 characters...")
	else:
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Username not filled...")


func _on_password_input_2_text_submitted(new_text):
	pass # Replace with function body.
