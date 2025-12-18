extends ProgressBar

@export var health : Health

@onready var damage_bar : ProgressBar = $Damage

#var prev_value : float

const HIT_AMOUNT = preload("uid://dtjuj82gav4h0")


#
#func take_damage(amount: float):
	#prev_value = value
	#value = clamp(value - amount, 0, max_value)
	#
	##damaged.emit(amount)
	#
	#if value <= 0:
		##died.emit()
		#
		#if owner != null:
			#owner.queue_free()
	#
#func heal(amount: float):
	#prev_value = value
	#value = clamp(value + amount, 0, max_value)
	##healed.emit(amount)
#
#func increase_max_health(amount: float):
	#max_value = max_value + amount
	#value = clampf(value, 0, max_value)

func _ready() -> void:
	damage_bar.value = value
	damage_bar.max_value = max_value
	
	health.health_changed.connect(update)

func update(current_health: float, max_health: float):
	var prev_value = value
	value = current_health
	max_value = max_health
	
	var tween = create_tween()
	
	var difference = value - prev_value
	
	var hit_amount : Label = HIT_AMOUNT.instantiate()
	
	hit_amount.text = str(int(difference))
	
	add_child(hit_amount)
	
	hit_amount.position.y = -size.y
	hit_amount.position.x = size.x * value / max_value - hit_amount.size.x / 2
	tween.tween_property(damage_bar, 'value', current_health, 0.3).set_delay(0.5)
#
#func _on_changed() -> void:
	#damage_bar.max_value = max_value
#
#func _on_value_changed(new_value: float) -> void:
	#var tween = create_tween()
	#
	#var difference = value - prev_value
	#
	#var hit_amount : Label = HIT_AMOUNT.instantiate()
	#
	#hit_amount.text = str(int(difference))
	#
	#add_child(hit_amount)
	#
	#hit_amount.position.y = -size.y
	#hit_amount.position.x = size.x * value / max_value - hit_amount.size.x / 2
	#tween.tween_property(damage_bar, 'value', new_value, 0.3).set_delay(0.5)
