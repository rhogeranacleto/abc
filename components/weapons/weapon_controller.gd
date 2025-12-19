extends Node2D
class_name WeaponController

@export var stats: Stats
@export var effecs: Array[Effect]
@export var range_area: Area2D
@export var cooldown: Timer

var range_shape = CircleShape2D.new()

func _ready() -> void:
	range_area.get_node('CollisionShape2D').shape = range_shape
	
	range_shape.radius = stats.get_final_value(Stats.Types.RANGE_BONUS)
