extends Node2D

@export var speed : float
@export var agent : Node2D
@export var target : Node2D
@export var sprite : CanvasItem

var current_speed : float

@onready var slow_cooldown: Timer = $SlowCooldown

signal slowed(modifier: float, duration: float)

func _ready() -> void:
	current_speed = speed

func _process(delta: float) -> void:
	if target != null and current_speed > 0:
			var direction = agent.global_position.direction_to(target.global_position).normalized()
			agent.global_position += direction * current_speed * delta

func calculate_speed() -> float:
	var all_effect_modifier = get_children().reduce(func (amount, child): return amount * child.speed_modifier, 1)
		
	return speed * all_effect_modifier

func _on_slow(modifier: float, duration: float) -> void:
	if not slow_cooldown.is_stopped():
		return
	
	current_speed = speed * modifier
	slow_cooldown.start(duration)
	if sprite != null:
		sprite.modulate = Color(0.0, 0.408, 1.0)
	
	await slow_cooldown.timeout
	
	current_speed = speed
	if sprite:
		sprite.modulate = Color.WHITE
