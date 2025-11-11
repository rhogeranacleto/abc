extends Node2D

@onready var cooldown: Timer = $Cooldown

const BULLET = preload("uid://8rmx7af40adk")
@onready var marker_2d: Marker2D = $Marker2D


func shoot():
	var bullet = BULLET.instantiate()
	
	get_tree().root.add_child(bullet)
	
	bullet.global_position = marker_2d.global_position
	pass


func _on_cooldown_timeout() -> void:
	shoot()
