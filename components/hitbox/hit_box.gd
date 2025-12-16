extends Area2D

@export var effects : Array[Effect] = []

signal hitted

func _ready() -> void:
	if owner != null:
		var owner_mask = owner.get('collision_mask')
		
		if owner_mask != null:
			collision_mask = owner_mask

func area_entered(area: Area2D):
	area.emit_signal('effects_applied', effects)
	hitted.emit()
