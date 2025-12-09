extends Node2D

@export var BULLET: PackedScene
@export var cooldown = 1.0

@onready var marker_2d: Marker2D = $Marker2D

func shoot(direction: Vector2) -> BT.Status:
	if BULLET == null or not $Cooldown.is_stopped():
		return BT.FAILURE
	
	var bullet = BULLET.instantiate()
	
	get_tree().root.add_child(bullet)
	
	bullet.global_position = marker_2d.global_position
	
	bullet.direction = direction
	$Cooldown.start(cooldown)
	return BT.SUCCESS
