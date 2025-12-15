extends Node2D

@export_flags_2d_physics var collision_mask : int
@export var cooldown = 1.0

@onready var hit_box: Area2D = $HitBox
@onready var cooldown_timer: Timer = $Cooldown
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var range_activator : RangeActivator = $RangeActivator

func _ready() -> void:
	hit_box.collision_mask = collision_mask
	range_activator.collision_mask = collision_mask
	range_activator.cooldown = cooldown

func _process(_delta: float) -> void:
	var targets = range_activator.get_overlapping_areas()
	
	if targets.is_empty():
		return
		
	var nearest = targets.reduce(Helpers.get_nearest_to_position.bind(global_position))
	
	look_at(nearest.global_position)


func _on_range_activator_activate(sorted_targets: Array[Area2D]) -> void:
	look_at(sorted_targets.get(0).global_position)
	animation_player.play('hit')
