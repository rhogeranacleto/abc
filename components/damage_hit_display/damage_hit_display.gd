extends Node2D

@export var value : float

@onready var label: Label = $Label

func _ready() -> void:
	label.text = str(value)
