extends CharacterBody2D

@export var team : Util.Team

@onready var effect_receiver = $EffectReceiver

func receive_hit(effects: Array[Effect], source: Node2D = null):
	for effect in effects:
		effect_receiver.apply_effect(effect, source)

func _on_health_changed(current_health: float, max_health: float) -> void:
	$Health.value = current_health
	$Health.max_value = max_health
