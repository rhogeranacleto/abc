extends Node
class_name UnitMover

@export var play_areas : Array[PlayArea]

func _ready() -> void:
	var units := get_tree().get_nodes_in_group('letters')
	
	for unit : Letter in units:
		setup_unit(unit)

func setup_unit(unit: Letter) -> void:
	unit.drag_and_drop.drag_started.connect(_on_unit_drag_started.bind(unit))
	unit.drag_and_drop.drag_canceled.connect(_on_unit_drag_canceled.bind(unit))
	unit.drag_and_drop.dropped.connect(_on_unit_dropped.bind(unit))

func _get_play_area_for_position(global: Vector2) -> int:
	for i in play_areas.size():
		var tile := play_areas[i].get_tile_from_global(global)
		
		if play_areas[i].is_tile_in_bounds(tile):
			return i
	
	return -1

func _reset_unit_to_starting_position(starting_position: Vector2, unit: Letter) -> void:
	var i := _get_play_area_for_position(starting_position)
	var tile := play_areas[i].get_tile_from_global(starting_position)
	
	unit.reset_after_dragging(starting_position)
	play_areas[i].unit_grid.add_unit(tile, unit)
	

func _on_unit_drag_started(unit: Letter) -> void:
	var i := _get_play_area_for_position(unit.global_position)
	
	if i > -1:
		var tile := play_areas[i].get_tile_from_global(unit.global_position)
		play_areas[i].unit_grid.remove_unit(tile)
	
func _on_unit_drag_canceled(starting_position: Vector2, unit: Letter) -> void:
	_reset_unit_to_starting_position(starting_position, unit)
	
func _on_unit_dropped(starting_position: Vector2, unit: Letter) -> void:
	var old_area_index := _get_play_area_for_position(starting_position)
	var drop_area_index := _get_play_area_for_position(unit.get_global_mouse_position())
	
	if drop_area_index == -1:
		_reset_unit_to_starting_position(starting_position, unit)
		return
	
	var old_area := play_areas[old_area_index]
	var old_tile := old_area.get_tile_from_global(starting_position)
	var new_area := play_areas[drop_area_index]
	var new_tile := new_area.get_hovered_tile()
	
	if new_area.unit_grid.is_tile_occupied(new_tile):
		var old_unit: Letter = new_area.unit_grid.units[new_tile]
		new_area.unit_grid.remove_unit(new_tile)
		_move_unit(old_unit, old_area, old_tile)
	
	_move_unit(unit, new_area, new_tile)

func _move_unit(unit: Letter, area: PlayArea, tile: Vector2i) -> void:
	area.unit_grid.add_unit(tile, unit)
	unit.global_position = area.get_global_from_tile(tile) - Arena.HALF_CELL_SIZE
	unit.reparent(area)
