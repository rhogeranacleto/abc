extends BTCondition

func _tick(delta: float) -> Status:
	if scene_root.get_tree().get_nodes_in_group('target').is_empty():
		return FAILURE
	return SUCCESS
