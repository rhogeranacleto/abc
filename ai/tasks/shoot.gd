extends BTAction

const BULLET = preload("uid://ds16y5s0r4nw8")

func _tick(delta: float) -> Status:
	var first = scene_root.get_tree().get_nodes_in_group('target').get(0)
	
	var direction = agent.position.direction_to(first.position).normalized()
	var bullet = BULLET.instantiate()
	
	scene_root.get_tree().root.add_child(bullet)
	
	bullet.global_position = agent.global_position
	bullet.direction = direction
	print('success')
	return SUCCESS
