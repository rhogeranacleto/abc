extends Node
class_name HealthHandler

@export var max_health := 100
@export var health := 100

signal health_changed(health: float, max_health: float)
