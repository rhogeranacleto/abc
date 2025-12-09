extends BTCondition

@export var area_range: NodePath

func _tick(_delta: float) -> Status:
	var weapon_range: Area2D = scene_root.get_node_or_null(area_range)
	
	if not is_instance_valid(weapon_range):
		return FAILURE
	
	if weapon_range.has_overlapping_areas():
		var targets = weapon_range.get_overlapping_areas()
		
		var nearest = targets.reduce(compare_nearest_with_current)
		
		blackboard.set_var('nearest_target', nearest)
		return SUCCESS
	
	return FAILURE

func compare_nearest_with_current(nearest: Node2D, current: Node2D):
	var nearest_distance = agent.global_position.distance_to(nearest.global_position)
	var current_distance = agent.global_position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current
