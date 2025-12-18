extends CharacterBody2D

@export var team : Util.Team
@export var stats : Stats

@onready var effect_receiver = $EffectReceiver
@onready var health : ProgressBar = $Health

func receive_hit(effects: Array[Effect], source: Node2D = null):
	for effect in effects:
		effect_receiver.apply_effect(effect, source)

func _on_health_changed(current_health: float, max_health: float) -> void:
	health.prev_value = health.value
	health.value = current_health
	health.max_value = max_health
