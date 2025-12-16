class_name Helpers extends Object

static func get_nearest_to_position(nearest: Node2D, current: Node2D, position: Vector2):
	var nearest_distance = position.distance_to(nearest.global_position)
	var current_distance = position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current

static func sort_by_distance_to(first: Node2D, second: Node2D, position: Vector2) -> bool:
	var first_distance = position.distance_to(first.global_position)
	var second_distance = position.distance_to(second.global_position)
	
	return first_distance < second_distance
