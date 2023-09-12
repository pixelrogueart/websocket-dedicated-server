extends Node2D
@onready var peerNode = preload("res://assets/peer/Peer.tscn")
@onready var peers = $Peers

var lastWorldState = 0

func spawn_player(playerID, spawnPosition):
	if Database.username == playerID:
		pass
	else:
		spawnPosition = GlobalFunctions.string_to_vector2(spawnPosition)
		var newPlayer = peerNode.instantiate()
		newPlayer.global_position = spawnPosition
		newPlayer.name = str(playerID)
		peers.add_child(newPlayer)

func despawn_player(player_id):
	var path = peers.get_path()
	var peer = str(path) + str("/", player_id)
	var peer_node = get_node(peer)
	peer_node.queue_free()

func update_world_state(worldState):
	#Buffer
	#Interpolation
	#Extrapolation
	#Rubber Banding
	if worldState["T"] > lastWorldState:
		lastWorldState = worldState["T"]
		worldState.erase("T")
		worldState.erase(Database.username)
		for player in worldState.keys():
			if peers.has_node(str(player)):
				if player != "undefined":
					var path = peers.get_path()
					var peer = get_node(str(path) + str("/" + str(player)))
					peer.update_state(worldState[player]["P"],worldState[player]["A"],worldState[player]["D"])
	#				else:
	#					despawn_player(player)
			else:
				if player != "undefined":
					spawn_player(player, worldState[player]["P"])
