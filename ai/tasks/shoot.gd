extends BTAction

@export var BULLET : PackedScene

func _tick(_delta: float) -> Status:
	var nearest: Node2D = blackboard.get_var('nearest_target')
	
	if not is_instance_valid(nearest):
		return FAILURE
	
	var direction = agent.global_position.direction_to(nearest.global_position).normalized()
	var bullet = BULLET.instantiate()
	
	scene_root.get_tree().root.add_child(bullet)
	
	bullet.global_position = agent.global_position
	bullet.direction = direction
	return SUCCESS
