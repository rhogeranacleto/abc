extends ProgressBar

@onready var damage_bar = $Damage

func _on_changed() -> void:
	damage_bar.max_value = max_value

func _on_value_changed(value: float) -> void:
	var tween = create_tween()
	
	tween.tween_property(damage_bar, 'value', value, 0.3).set_delay(0.5)
