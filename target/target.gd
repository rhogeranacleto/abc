extends Node2D

@export var speed = 100



func X_process(delta: float) -> void:
	if speed > 0:
		var soldiers = get_tree().get_nodes_in_group('soldier')
		
		var nearest = soldiers.reduce(compare_nearest_with_current)
		
		var direction = global_position.direction_to(nearest.global_position).normalized()
		
		global_position += direction * speed * delta

func compare_nearest_with_current(nearest: Node2D, current: Node2D):
	var nearest_distance = global_position.distance_to(nearest.global_position)
	var current_distance = global_position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current
