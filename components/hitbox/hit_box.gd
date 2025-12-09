extends Area2D

@export var damage = 1.0
@export_enum('one_hit', 'continuous') var mode = 'continuous'

signal hitted

func _ready() -> void:
	if mode == 'one_hit':
		set_process(false)
		connect("area_entered", area_entered)

func _process(_delta: float) -> void:
	var areas = get_overlapping_areas()
	
	if not areas.is_empty():
		for area in areas:
			area.emit_signal('hurt', damage)
		hitted.emit()

func area_entered(area: Area2D):
	area.emit_signal('hurt', damage)
	hitted.emit()
