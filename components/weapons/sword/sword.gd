extends RangeActivator

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: Area2D = $HitBox

func _ready() -> void:
	hit_box.collision_mask = collision_mask

func _on_activate(sorted_targets: Array[Area2D]) -> void:
	var attack_animation = animation_player.get_animation("attack")
	
	#print(1 / (cooldown * 1.2) / attack_animation.length)
	
	animation_player.play("attack")
	pass # Replace with function body.
