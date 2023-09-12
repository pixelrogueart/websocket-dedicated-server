extends Node

var httpRequest = HTTPRequest.new()
var dbURL = ""

var username = ""

func _ready():
	httpRequest.request_completed.connect(self._on_request_completed)
	self.add_child(httpRequest)

func register(username,password,email):
	var data = {"username":username,"password":password,"email":email}
	http_request(dbURL+"/register",data)
	GlobalSignals.emit_signal("SEND_NOTIFICATION","Registering account...")

func login(username,password):
	var data = {"email":username,"password":password}
	http_request(dbURL+"/login",data)
	GlobalSignals.emit_signal("SEND_NOTIFICATION","Trying login...")

func request_player_info(playerID):
	var data = {"username":playerID}
	http_request(dbURL+"/requestPlayerInfo",data)

func update_player_info(description, arrestInfo):
	var data = {"username":username, "description":description, "arrestInfo":arrestInfo}
	http_request(dbURL+"/updatePlayerInfo",data)

func http_request(url,data) -> void:
	var headers = ["Content-Type: application/json"]
	var body = JSON.new().stringify(data)
	var error = httpRequest.request(url, headers, HTTPClient.METHOD_POST, body)
	if error == OK:
		GlobalSignals.emit_signal("CHANGE_BUTTON_STATE",true)
		"Request sent"
	else:
		GlobalSignals.emit_signal("CHANGE_BUTTON_STATE",false)
		GlobalSignals.emit_signal("SEND_NOTIFICATION","Error sending request.")

func _on_request_completed(result, response_code, headers, body):
	var jsonResult = {}
	if response_code == 200:
		var json = JSON.new()
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		match response["action"]:
			"login_successful":
				GlobalSignals.emit_signal("CHANGE_SCREEN","Play")
				GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				username = response["username"]
				Server.try_server_connection(Server._server_url)
			"register_successful":
				GlobalSignals.emit_signal("CHANGE_SCREEN","Menu")
				GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
			"retrieve_player_info":
				GlobalSignals.emit_signal("DISPLAY_INFO","user",response["userInfo"])
			"update_successful":
				GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				
		httpRequest.request_completed.disconnect(self._on_request_completed)
	else:
		var json = JSON.new()
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		if "action" in response:
			match response["action"]:
				"login_failed":
					GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				"register_failed":
					GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				"update_failed":
					GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				"player_info_not_found":
					GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
				"player_info_failed":
					GlobalSignals.emit_signal("SEND_NOTIFICATION",response["message"])
		else:
			GlobalSignals.emit_signal("SEND_NOTIFICATION","Unknown error")
	GlobalSignals.emit_signal("CHANGE_BUTTON_STATE",false)
