extends Node2D

@export var BULLET: PackedScene

@onready var marker_2d: Marker2D = $Marker2D

func shoot():
	if BULLET == null:
		return
	
	var bullet = BULLET.instantiate()
	
	get_tree().root.add_child(bullet)
	
	bullet.global_position = marker_2d.global_position
	
	pass
