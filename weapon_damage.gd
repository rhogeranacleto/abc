extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('target'):
		area.emit_signal('hurt', 40)
