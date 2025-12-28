extends CharacterBody2D
class_name Soldier

@export var team : Util.Team
@export var stats : Stats

@onready var effect_receiver = $EffectReceiver
@onready var stats_handler : StatsHandler = $StatsHandler
@onready var status_effect_manager : StatusEffectManager = $StatusEffectManager

func _ready() -> void:
	update_team_collision()
	
	#print(name)
	
	#for child in get_children():
		#if child.is_in_group('weapon'):
			#print(child)

func update_team_collision():
	match team:
		Util.Team.PLAYER:
			collision_layer = 1
		Util.Team.ENEMY:
			collision_layer = 2

func receive_hit(effects: Array[Effect], source: Node2D = null):
	for effect in effects:
		match effect.get_script():
			StatBuff:
				stats_handler.apply_buff(effect)
			DamageEffect, HealEffect:
				status_effect_manager.apply_effect(effect)

func _on_health_died() -> void:
	queue_free()
