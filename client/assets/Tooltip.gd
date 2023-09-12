extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() is Peer:
		self.tooltip_text = get_parent().name


