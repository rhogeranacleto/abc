extends ProgressBar

@export var health_handler : HealthHandler

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not health_handler == null:
		health_handler.health_changed.connect(update_health_value)
		update_health_value(health_handler.health, health_handler.max_health)

func update_health_value(health: float, max_health: float):
	max_value = max_health
	value = health
