extends BTCondition

@export var area_range: NodePath

func _tick(_delta: float) -> Status:
	var weapon_range: Area2D = scene_root.get_node_or_null(area_range)
	
	if not is_instance_valid(weapon_range):
		return FAILURE
	
	return SUCCESS if weapon_range.has_overlapping_areas() else FAILURE
