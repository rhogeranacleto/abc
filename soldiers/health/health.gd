extends Node
class_name Health

@export var stats_handler : StatsHandler

var _current_health : float
var _max_health : float

signal died
signal health_changed(_current_health: float, max_health: float)
signal damaged(amount: float)
signal healed(amount: float)

func _ready() -> void:
	recalculate_max_health()
	_current_health = _max_health
	
	stats_handler.stats.max_health.modifier_changed.connect(recalculate_max_health)

func take_damage(amount: float):
	var prev_current_amount = _current_health
	_current_health = clamp(_current_health - amount, 0, _max_health)
	
	if _current_health != prev_current_amount:
		health_changed.emit(_current_health, _max_health)
		damaged.emit(amount)
	
	if _current_health <= 0:
		died.emit()

func heal(amount: float):
	var prev_current_amount = _current_health
	_current_health = clamp(_current_health + amount, 0, _max_health)
	
	if _current_health != prev_current_amount:
		health_changed.emit(_current_health, _max_health)
		healed.emit(amount)
	
func recalculate_max_health():
	_max_health = stats_handler.stats.max_health.calculate_final_value()
	
	_current_health = clamp(_current_health, 0, _max_health)
	
	health_changed.emit(_current_health, _max_health)
