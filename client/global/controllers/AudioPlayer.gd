extends AudioStreamPlayer2D


func _on_finished():
	self.queue_free()
