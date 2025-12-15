extends Node2D

@export_flags_2d_physics var collision_mask : int
@export var shape : CircleShape2D
@export var cooldown = 1.0

func _ready() -> void:
	$HitBox.collision_mask = collision_mask
	$RangeActivator.collision_mask = collision_mask
	$HitBox/CollisionShape2D.shape = shape
	$RangeActivator/CollisionShape2D.shape = shape
	$RangeActivator.cooldown = cooldown


func _on_range_activator_activate(sorted_targets: Array[Area2D]) -> void:
	$AnimationPlayer.play("hit")
