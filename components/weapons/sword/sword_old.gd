extends Node2D

@export_flags_2d_physics var collision_mask : int = 0
@export var cooldown = 1.0

@onready var range_activator = $RangeActivator
@onready var hit_box = $HitBox
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	range_activator.collision_mask = collision_mask
	hit_box.collision_mask = collision_mask
	#range_activator.cooldown = cooldown


func _on_range_activator_activate(sorted_targets: Array[Node2D]) -> void:
	animation_player.play("attack")
