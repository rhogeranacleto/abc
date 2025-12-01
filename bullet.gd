extends Area2D

@export var direction: Vector2
@export var speed = 200

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('target'):
		area.emit_signal('hurt', 5)
	pass # Replace with function body.
