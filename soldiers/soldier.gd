extends CharacterBody2D

@export var team : Util.Team
@export var stats : Stats

@onready var effect_receiver = $EffectReceiver
@onready var stats_handler : StatsHandler = $StatsHandler
@onready var status_effect_manager : StatusEffectManager = $StatusEffectManager


func receive_hit(effects: Array[Effect], source: Node2D = null):
	for effect in effects:
		match effect.get_script():
			StatBuff:
				stats_handler.apply_buff(effect)
			DamageEffect, HealEffect:
				status_effect_manager.apply_effect(effect)

func _on_health_died() -> void:
	queue_free()
