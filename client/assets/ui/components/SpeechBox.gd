extends Label

@onready var timer = $Timer

func _ready():
	GlobalSignals.connect("SEND_TEXT",update_text)

func update_text(text):
	if get_parent() is Player:
		self.show()
		self.text = text
		timer.start(3)

func _on_timer_timeout():
	self.text = ""
	self.hide()
