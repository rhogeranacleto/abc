extends BTCondition

func _tick(_delta: float) -> Status:
	var targets = scene_root.get_tree().get_nodes_in_group('target')
	
	if targets.is_empty():
		return FAILURE
	
	var nearest = targets.reduce(compare_nearest_with_current)
	
	blackboard.set_var('nearest_target', nearest)
	
	return SUCCESS

func compare_nearest_with_current(nearest: Node2D, current: Node2D):
	var nearest_distance = agent.global_position.distance_to(nearest.global_position)
	var current_distance = agent.global_position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current
