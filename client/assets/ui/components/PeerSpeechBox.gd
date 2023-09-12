extends Label

@onready var timer = $Timer

func _ready():
	GlobalSignals.connect("RECEIVE_TEXT",update_received_text)
	
func update_received_text(peerID,text):
	if peerID != Database.username:
		self.show()
		self.text = text
		timer.start(3)

func _on_timer_timeout():
	self.text = ""
	self.hide()
