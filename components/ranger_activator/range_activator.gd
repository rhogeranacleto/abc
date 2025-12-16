class_name RangeActivator extends Area2D

#@export var cooldown = 1.0

@onready var cooldown_timer: Timer = $Cooldown
#@onready var cooldown

signal activate(sorted_targets: Array[Area2D])

func _ready() -> void:
	collision_mask = owner.get('collision_mask')

func _process(_delta: float) -> void:
	var targets = get_overlapping_areas()
	
	if targets.is_empty():
		return
	
	targets.sort_custom(Helpers.sort_by_distance_to.bind(global_position))
	
	activate.emit(targets)
	
	if owner.cooldown > 0.0 and cooldown_timer != null:
		start_cooldown(owner.cooldown)

func start_cooldown(value: float):
	cooldown_timer.start(value)
	set_process(false)

func _on_cooldown_timeout() -> void:
	set_process(true)
