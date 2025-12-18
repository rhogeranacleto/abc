extends Resource
class_name Stat

signal modifier_changed

@export var base_value : int
@export var modifiers : Array[Modifier]

func apply_modifier(modifier: Modifier):
	pass
