extends Node
class_name Health

@export var stats_handler : StatsHandler

var current_health : float

signal died
signal health_changed(current_health: float, max_health: float)

func _ready() -> void:
	current_health = stats_handler.stats.max_health.base_value

func take_damage(amount: float):
	current_health = clamp(current_health - amount, 0, stats_handler.stats.max_health.base_value)
	
	health_changed.emit(current_health, stats_handler.stats.max_health.base_value)
	
	if current_health <= 0:
		died.emit()
		
		#if owner != null:
			#owner.queue_free()

func heal(amount: float):
	current_health = clamp(current_health + amount, 0, stats_handler.stats.max_health.base_value)
	
	health_changed.emit(current_health, stats_handler.stats.max_health.base_value)
	
