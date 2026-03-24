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

var selected := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_layer = team
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
