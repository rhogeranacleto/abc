extends Node2D

@export var target : Node2D

const PROJECTILE_PATH = preload("uid://dnn3pmet6y2tu")

func _ready() -> void:
	create_projectile_path()

func create_projectile_path():
	var path = PROJECTILE_PATH.instantiate()
	
	path.target = target.global_position
	path.global_position = global_position
	
	get_tree().root.call_deferred('add_child', path)
	
	pass

func _on_timer_timeout() -> void:
	create_projectile_path()
