extends Area2D

@export var effects : Array[Effect] = []

signal hitted

func area_entered(area: Area2D):
	area.emit_signal('effects_applied', effects)
	hitted.emit()
