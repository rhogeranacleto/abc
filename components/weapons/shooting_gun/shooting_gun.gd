extends Node2D

@export var range = 300.0
@export var cooldown = 1.0
@export var BULLET : PackedScene
@export_flags_2d_physics var collision_mask : int

@onready var range_activator: RangeActivator = $RangeActivator
@onready var marker_2d: Marker2D = $Gun/Marker2D
@onready var collision_shape_2d: CollisionShape2D = $RangeActivator/CollisionShape2D

func _ready() -> void:
	range_activator.collision_mask = collision_mask

func _process(delta: float) -> void:
	var targets_in_area = range_activator.get_overlapping_areas()
	
	if targets_in_area.is_empty():
		return
	
	var nearest = targets_in_area.reduce(Helpers.get_nearest_to_position.bind(global_position))
	
	look_at(nearest.global_position)

func _on_range_activator_activate(sorted_targets: Array[Area2D]) -> void:
	var bullet = BULLET.instantiate()
	
	get_tree().root.add_child(bullet)
	
	bullet.global_position = marker_2d.global_position
	bullet.rotation = rotation
	range_activator.start_cooldown(cooldown)
