extends Area2D

@export var cooldown = 1.0
@export var max_health = 100 :
	set(value):
		max_health = value
		
		if max_health < health:
			health = max_health
		
		health_bar.max_value = max_health
		
@export var health = 100 :
	set(value):
		health = min(value, max_health)
		health_bar.value = health

@export var health_bar : ProgressBar
@export var agent : Node2D

@onready var cooldown_timer: Timer = $Cooldown

signal hurt(amount: float)

func _on_hurt(amount: float) -> void:
	if not cooldown_timer.is_stopped():
		return
	
	health -= amount
	
	if cooldown > 0.0:
		cooldown_timer.start(cooldown)
	
	if health < 0 and agent != null:
		agent.queue_free()
