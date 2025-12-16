extends Area2D

@onready var cooldown: Timer = $Cooldown
@onready var hit_box: Area2D = $HitBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	var targets = get_overlapping_areas()
	
	if targets.is_empty():
		return
	
	var nearest = targets.reduce(Helpers.get_nearest_to_position.bind(global_position))
	
	look_at(nearest.global_position)
	animation_player.play("hit")
	cooldown.start()
	set_process(false)


func _on_cooldown_timeout() -> void:
	set_process(true)
