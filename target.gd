extends Area2D

@onready var life_indicator: Label = $LifeIndicator

@export var life = 100:
	set(value):
		life = value
		if life_indicator:
			life_indicator.text = str(value)

signal hurt(amount: int)

func _on_hurt(amount: int) -> void:
	life -= amount
	
	if life <= 0:
		queue_free()
	pass # Replace with function body.
