extends Area2D

@export var damage = 1.0
@export_enum('one_hit', 'continuous') var mode = 'continuous'
@export var damage_curve : Curve
@export var damage_offset : float

signal hitted

func _ready() -> void:
	if mode == 'one_hit':
		set_process(false)
		connect("area_entered", area_entered)

func _process(_delta: float) -> void:
	var areas = get_overlapping_areas()

	if not areas.is_empty():
		var calculated_damage = damage if damage_curve == null else damage_curve.sample(damage_offset) * damage
		
		for area in areas:
			area.emit_signal('hurt', calculated_damage)
		hitted.emit()

func area_entered(area: Area2D):
	area.emit_signal('hurt', damage)
	hitted.emit()
