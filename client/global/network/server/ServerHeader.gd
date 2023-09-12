class_name ServerHeader
extends Node

@onready var world = get_node("/root/World")

var _ws := WebSocketPeer.new()
var _server_url: String = ""
var connected = false
var reconnecting = false
var uuid = null
