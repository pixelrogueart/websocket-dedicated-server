extends Control

@onready var userInput = $Panel/UserInput
@onready var passwordInput = $Panel/PasswordInput

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_pressed():
	Database.login(userInput.text,passwordInput.text)

func _on_register_button_pressed():
	GlobalSignals.emit_signal("CHANGE_SCREEN","Register")
	userInput.text = ""
	passwordInput.text = ""

func _on_password_input_text_submitted(new_text):
	if new_text != "":
		if new_text.length() >= 6:
			Database.login(userInput.text,passwordInput.text)
		else:
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Password needs at least 6 characters...")
	else:
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Password not filled...")

func _on_user_input_text_submitted(new_text):
	if new_text != "":
		if new_text.length() >= 4:
			Database.login(userInput.text,passwordInput.text)
		else:
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Username needs at least 4 characters...")
	else:
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Username not filled...")
