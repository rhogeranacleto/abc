extends BTAction

@export var gun : NodePath

func _tick(_delta: float) -> Status:
	var nearest: Node2D = blackboard.get_var('nearest_target')
	var gun_instance = agent.get_node(gun)
	
	if not is_instance_valid(gun_instance) or not is_instance_valid(nearest):
		return FAILURE
	
	var direction = agent.global_position.direction_to(nearest.global_position).normalized()
	
	return gun_instance.shoot(direction);
