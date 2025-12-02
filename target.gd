extends Area2D

@export var speed = 100

@export var life = 100:
	set(value):
		life = value
		if life_indicator:
			life_indicator.text = str(value)

@onready var life_indicator: Label = $LifeIndicator

signal hurt(amount: int)

func _on_hurt(amount: int) -> void:
	life -= amount
	
	if life <= 0:
		queue_free()
	pass # Replace with function body.

func _process(delta: float) -> void:
	var soldier = get_tree().get_nodes_in_group('soldier').get(0)
	
	var direction = global_position.direction_to(soldier.global_position).normalized()
	
	global_position += direction * speed * delta
