extends Label

const HEAL_COLOR = Color(0.275, 1.0, 0.0)
const DAMAGE_COLOR = Color(0.905, 0.0, 0.0)

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("heal" if float(text) > 0 else "damage")
	
	animation_player.animation_finished.connect(queue_free)
