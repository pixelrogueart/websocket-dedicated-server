extends ServerFunctions

@onready var networkTimer = $Timer

func _ready():
	set_process(false)
	
func _process(delta):
	_ws.poll()
	var state = _ws.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		if !connected:
			broadcast("readyPlayer",{"username":Database.username})
			GlobalSignals.emit_signal("CHANGE_PLAYER_STATE",true)
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Connected...")
		reconnecting = false
		connected = true
		while _ws.get_available_packet_count():
			on_data_received()
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CONNECTING:
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Connecting...")
	elif state == WebSocketPeer.STATE_CLOSED:
		GlobalSignals.emit_signal("CHANGE_PLAYER_STATE",false)
		connected = false
		var code = _ws.get_close_code()
		var reason = _ws.get_close_reason()
		GlobalSignals.emit_signal("CHANGE_SCREEN","Menu")
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Disconnected...")
		try_server_connection(_server_url)
		networkTimer.start(1)
		set_process(false) # Stop processing.

func _on_timer_timeout():
	try_server_connection(_server_url)

func try_server_connection(url):
	var state = _ws.get_ready_state()
	set_process(true)
	if state == WebSocketPeer.STATE_CLOSED:
		GlobalSignals.emit_signal("CHANGE_PLAYER_STATE",false)
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Disconnected...")
		_ws.connect_to_url(url)
	elif state == WebSocketPeer.STATE_CONNECTING:
		GlobalSignals.emit_signal("CHANGE_PLAYER_STATE",false)
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Connecting...")
	elif state == WebSocketPeer.STATE_OPEN:
		networkTimer.stop()
		broadcast("readyPlayer",{"username":Database.username})
		GlobalSignals.emit_signal("CHANGE_PLAYER_STATE",true)
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Connected...")

func on_data_received():
	var package = (_ws.get_packet().get_string_from_utf8())
	var json = JSON.new()
	var parsedPackage = JSON.parse_string(package)
	if "action" in parsedPackage:
		match parsedPackage["action"]:
			"receive_world_state":
				world.update_world_state(parsedPackage["data"])
			"assignUUID":
				uuid = parsedPackage["uuid"]
			"error":
				GlobalSignals.emit_signal("SEND_NOTIFICATION",parsedPackage["message"])
			"broadcast":
				if "data" in parsedPackage:
					if "function" in parsedPackage["data"]:
						if "parameters" in parsedPackage["data"]:
							call(parsedPackage["data"]["function"],parsedPackage["data"]["parameters"])
	else:
#		print("Invalid action: ", parsedPackage)
		pass
