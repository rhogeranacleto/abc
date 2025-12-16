extends Node2D

@export_flags_2d_physics var collision_mask : int
@export var speed = 2000
@export var effects : Array[Effect]

func _process(delta: float) -> void:
	global_position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hit_box_hitted() -> void:
	print(effects)
	queue_free()
