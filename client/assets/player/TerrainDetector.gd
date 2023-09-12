extends Area2D

@onready var player = $".."
var tilemap
var standingTile = "footstep_grass"

func _physics_process(delta):
	if player.velocity > Vector2.ZERO:
		if tilemap:
			define_standing_tile(player.global_position)

func _on_body_entered(body):
	if body is TileMap:
		tilemap = body

func define_standing_tile(pos):
	var localMapPos = tilemap.local_to_map(pos)
	var data = tilemap.get_cell_tile_data(0, localMapPos)
	if data:
		standingTile = data.get_custom_data("terrain_sfx")

