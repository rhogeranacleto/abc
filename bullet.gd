extends Node2D

@export var direction: Vector2
@export var speed = 200

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hit_box_hitted() -> void:
	queue_free()
