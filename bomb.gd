extends Node2D

signal hit

const EXPLOSION_AREA = preload("uid://3xrf5mjjc1ky")

func _on_hit() -> void:
	var explosion_area = EXPLOSION_AREA.instantiate()
	
	add_child(explosion_area)
	
	explosion_area.owner = owner
