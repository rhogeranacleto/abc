class_name UnitGrid
extends Node2D

@export var size : Vector2i

signal unit_grid_changed

var units : Dictionary

func _ready() -> void:
	for i in size.x:
		for j in size.y:
			units[Vector2i(i, j)] = null
	
func add_unit(tile: Vector2i, unit: Node) -> void:
	units[tile] = unit
	unit_grid_changed.emit()

func remove_unit(tile: Vector2i) -> void:
	var unit := units[tile] as Node
	
	if not unit:
		return
	
	units[tile] = null
	unit_grid_changed.emit()

func is_tile_occupied(tile: Vector2i) -> bool:
	return units[tile] != null
