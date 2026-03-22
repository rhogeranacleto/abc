extends Node2D
class_name Letter

@export var team := TEAM.player

enum TEAM {
	player = 1,
	enemy = 2
}

@onready var hurt_box: Area2D = $HurtBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_box.collision_layer = team
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
