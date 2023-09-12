extends Node2D

var currentDirection = "down"
var oldDirection = ""
var flip = false

var traits = {
	"body": "regular",
	"eyes": 1,
	"hairstyles": 1,
	"mouths": 1,
	"shoes": 1,
	"top": 1,
	"bottoms": 1,
}

@onready var traitsNodes = {
	"body":$body,
	"eyes":$eyes,
	"hairstyles":$hairstyles,
	"mouths":$mouths,
	"shoes":$shoes,
	"top":$top,
	"bottoms":$bottoms,
}

func _ready():
	randomize()
	pick_random_trait()
	update_traits()

func _process(_delta):
	if oldDirection != currentDirection:
		update_traits()
		oldDirection = currentDirection

func pick_random_trait():
	for layer in traits:
		if layer == "body":
			continue
		traits[layer] = randi_range(1,5)
	var bodyType = randi_range(1,3)
	match bodyType:
		1:
			bodyType = "regular"
		2:
			bodyType = "fat"
		3:
			bodyType = "tall"
	traits["body"] = bodyType

func update_traits():
	var texture
	for layer in traits:
		if layer == "body":
			continue
		var path
		if ResourceLoader.exists("res://sprites/character/traits/%s/%s/%s/%s.png" %[traits["body"],currentDirection,layer,str(traits[layer])]):
			path = "res://sprites/character/traits/%s/%s/%s/%s.png" %[traits["body"],currentDirection,layer,str(traits[layer])]
		else:
			traitsNodes[layer].texture = null
			continue
		texture = load(path)
		traitsNodes[layer].texture = texture
	texture = load("res://sprites/character/body/%s/%s.png" %[traits["body"],currentDirection])
	traitsNodes["body"].texture = texture

func verify_direction():
	var angle = rad_to_deg(get_parent().angleMovement.rotation)
	if -22.5 <= angle and angle < 22.5:
		currentDirection = "right"
	elif 22.5 <= angle and angle < 67.5:
		currentDirection = "downright"
	elif 67.5 <= angle and angle < 112.5:
		currentDirection = "down"
	elif 112.5 <= angle and angle < 157.5:
		currentDirection = "downleft"
	elif -22.5 > angle and angle >= -67.5:
		currentDirection = "upright"
	elif -67.5 > angle and angle >= -112.5:
		currentDirection = "up"
	elif -112.5 > angle and angle >= -157.5:
		currentDirection = "upleft"
	else:
		currentDirection = "left"

func flip_sprite(_flip: bool):
	for layer in traitsNodes:
		if traitsNodes[layer].flip_h != _flip:
			traitsNodes[layer].flip_h = _flip
			flip = _flip

