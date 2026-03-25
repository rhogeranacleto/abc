@tool
extends Area2D
class_name Letter

@export var team := TEAM.player
@export var letter_character := 'A' : 
	set = set_letter_character

enum TEAM {
	player = 1,
	enemy = 2
}

@onready var hurt_box: Area2D = $HurtBox
@onready var label: Label = $Label
@onready var drag_and_drop : DragAndDrop = $DragAndDrop

var selected := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = team
	
	if not Engine.is_editor_hint():
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)
	pass # Replace with function body.

func set_letter_character(new_value: String) -> void:
	letter_character = new_value
	
	if not is_node_ready():
		await ready
	
	label.text = new_value


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		if selected:
			unselect_letter()
		else:
			select_letter()

func select_letter() -> void:
	selected = true
	#label.scale = Vector2.ONE * 1.5
	
func unselect_letter() -> void:
	selected = false
	#label.scale = Vector2.ONE

func reset_after_dragging(starting_position: Vector2) -> void:
	global_position = starting_position

func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)
