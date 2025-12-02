extends Area2D

@export var cooldown = 1.0

@onready var cooldown_timer: Timer = $Cooldown

signal hurt(amount: int)

func _ready() -> void:
	cooldown_timer.wait_time = cooldown

func _process(_delta: float) -> void:
	var areas = get_overlapping_areas()
	
	if not areas.is_empty():
		print(areas)
		hurt.emit(5)
		set_process(false)
		cooldown_timer.start()
	pass

func _on_cooldown_timeout() -> void:
	set_process(true)
	pass # Replace with function body.
