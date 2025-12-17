extends Node2D

@export var speed = 100
@export var after_hit_effect : Array[Effect]

@onready var effect_receiver: Node2D = $EffectReceiver

func X_process(delta: float) -> void:
	if speed > 0:
		var soldiers = get_tree().get_nodes_in_group('soldier')
		
		var nearest = soldiers.reduce(compare_nearest_with_current)
		
		var direction = global_position.direction_to(nearest.global_position).normalized()
		
		global_position += direction * speed * delta

func compare_nearest_with_current(nearest: Node2D, current: Node2D):
	var nearest_distance = global_position.distance_to(nearest.global_position)
	var current_distance = global_position.distance_to(current.global_position)
	
	return nearest if nearest_distance < current_distance else current

func receive_hit(effects: Array[Effect], source: Node2D):
	if effect_receiver.active_states.has(Util.EffectType.INVULNERABLE):
		return
	
	for effect in effects:
		effect_receiver.apply_effect(effect, source)
	
	for after_effect in after_hit_effect:
		effect_receiver.apply_effect(after_effect)


func _on_effect_receiver_health_changed(current_health: float, max_health: float) -> void:
	$ProgressBar.value = current_health
	$ProgressBar.max_value = max_health

func _on_effect_receiver_died() -> void:
	queue_free()


func _on_effect_started(effect_type: Util.EffectType) -> void:
	if effect_type == Util.EffectType.INVULNERABLE:
		modulate = Color(1, 1, 1, 0.5)


func _on_effect_ended(effect_type: Util.EffectType) -> void:
	if effect_type == Util.EffectType.INVULNERABLE:
		modulate = Color(1, 1, 1, 1)
