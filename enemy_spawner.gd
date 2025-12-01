extends Marker2D

@export var enemy_scene: PackedScene

func _on_timer_timeout() -> void:
	print(get_tree().get_nodes_in_group('target').size())
	if get_tree().get_nodes_in_group('target').size() < 3:
		var enemy = enemy_scene.instantiate()
		
		get_tree().root.add_child(enemy)
		
		enemy.global_position = global_position
