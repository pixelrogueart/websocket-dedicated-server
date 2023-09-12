class_name ServerFunctions
extends ServerHeader

#client-server
func broadcast(action, data):
	var message = {
		"action": action,
		"data": data
	}
	var json = JSON.new()
	var parsedData = json.stringify(message)
	_ws.send_text(parsedData)

#client-requests
func send_text(text,pos):
	randomize()
	var username = Database.username
	var audioIndex = randi()%AudioController.audioLibrary["gibberish"].size()
	var data = {"parameters":{"username":username, "text":text,"position":pos,"audioIndex":audioIndex},"function": "receive_text"}
	broadcast("broadcast",data)

func request_play_audio(audio,position):
	AudioController.play_audio(audio,position)
	var data = {"parameters":{"audio":audio, "position":position, "user": Database.username},"function": "play_audio"}
	broadcast("broadcast",data)

#server-callables
func receive_server_notification(params):
	GlobalSignals.emit_signal("SEND_NOTIFICATION",params["message"])

func despawn_player(params):
	world.despawn_player(params["username"])

func receive_text(params):
	AudioController.play_audio("gibberish",params["position"],params["audioIndex"])
	GlobalSignals.emit_signal("RECEIVE_TEXT",params["username"],params["text"])

func load_player_state(params):
	GlobalSignals.emit_signal("LOAD_PLAYER_STATE",params["userData"])

func play_audio(params):
	if params["user"] != Database.username:
		AudioController.play_audio(params["audio"],params["position"])
