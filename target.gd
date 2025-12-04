extends Area2D

@export var speed = 100

@export var life = 100:
	set(value):
		life = value
		if life_indicator:
			life_indicator.text = str(value)

@onready var life_indicator: Label = $LifeIndicator

signal hurt(amount: int)

func _ready() -> void:
	life_indicator.text = str(life)

func _on_hurt(amount: int) -> void:
	life -= amount
	
	if life <= 0:
		queue_free()
	pass # Replace with function body.

func _process(delta: float) -> void:
	var soldiers = get_tree().get_nodes_in_group('soldier')
	
	var nearest = soldiers.reduce(compare_nearest_with_current)
	
	var direction = global_position.direction_to(nearest.global_position).normalized()
	
	global_position += direction * speed * delta

func compare_nearest_with_current(nearest: Node2D, current: Node2D):
	var nearest_distance = global_position.distance_to(nearest.global_position)
	var current_distance = global_position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current
