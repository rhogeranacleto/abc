extends Node
class_name StatusEffectManager

@export var health : Health

var active_effects : Array[Dictionary]

func apply_effect(effect: Effect):
	if effect.duration > 0.0:
		append_active_effect(effect)
	else:
		handle_effect(effect)

func handle_damage(effect: DamageEffect):
	health.take_damage(effect.amount)

func handle_heal(effect: HealEffect):
	health.heal(effect.amount)

func handle_effect(effect: Effect):
	match effect.get_script():
		DamageEffect:
			handle_damage(effect)
		HealEffect:
			handle_heal(effect)

func append_active_effect(effect: Effect):
	active_effects.append({
		"effect": effect,
		"timer": 0.0,
		"elapsed": 0.0
	})

func _process(delta: float) -> void:
	for active_effect in active_effects:
		var effect = active_effect['effect']
		active_effect['timer'] += delta
		active_effect['elapsed'] += delta
		
		if active_effect['elapsed'] >= effect.tick_interval:
			active_effect['elapsed'] = 0.0
			handle_effect(effect)
		
		if active_effect['timer'] >= effect.duration:
			active_effects.erase(active_effect)
