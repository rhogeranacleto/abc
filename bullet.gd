extends Node2D

const SPEED = 100

func _process(delta: float) -> void:
	global_position = global_position + Vector2(SPEED, 0) * delta
	
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
