extends Node

func string_to_vector2(s: String) -> Vector2:
	var parts = s.replace("(", "").replace(")", "").split(",")
	return Vector2(int(parts[0]), int(parts[1]))

func vector2_to_string(vec: Vector2) -> String:
	return "(%s, %s)" % [vec.x, vec.y]
