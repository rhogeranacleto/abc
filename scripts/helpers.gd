class_name Helpers extends Object

static func get_nearest_to_position(nearest: Node2D, current: Node2D, position: Vector2):
	var nearest_distance = position.distance_to(nearest.global_position)
	var current_distance = position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current
