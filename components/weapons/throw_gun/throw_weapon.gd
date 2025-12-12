extends Area2D

#@export var target : Node2D

const PROJECTILE_PATH = preload("uid://dnn3pmet6y2tu")

@onready var cooldown: Timer = $Cooldown

func _process(delta: float) -> void:
	var targets = get_overlapping_areas()
	if not targets.is_empty():
		var nearest = targets.reduce(Helpers.get_nearest_to_position.bind(global_position))
		
		create_projectile_path(nearest)
		cooldown.start()
		set_process(false)

func create_projectile_path(target: Node2D):
	var path = PROJECTILE_PATH.instantiate()
	
	path.target = target.global_position
	path.global_position = global_position
	
	get_tree().root.add_child(path)
	
	pass

func _on_timer_timeout() -> void:
	set_process(true)
