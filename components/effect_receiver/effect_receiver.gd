extends Node2D

# code taken from https://youtu.be/pNBWcw_xliA?si=zHStKFVgIX8YPSgg

signal effect_started(effect_type: Util.EffectType)
signal effect_ended(effect_type: Util.EffectType)

@export var health : Health
@export var stats_handler :  StatsHandler

var velocity_knockback : Vector2 = Vector2.ZERO
var knockback_friction : float = 800.0

var active_overtime_effects: Array[Dictionary] = []
var active_stat_modifiers: Dictionary = {}

var speed_multiplier := 1.0
var attack_multiplier := 1.0
var defense_multiplier := 1.0
var range_multiplier := 1.0

var active_states: Dictionary = {}
var state_timers: Dictionary = {}

func _physics_process(delta: float) -> void:
	process_overtime_effect(delta)
	process_stat_modifiers(delta)
	process_state_timers(delta)
	process_knockback(delta)

func apply_effect(effect: Effect, source: Node2D = null):
	print(effect)
	
	#effect_started.emit(effect)
	
	match effect.get_script():
		StatBuff:
			print('bugg', effect)
		DamageEffect, HealEffect:
			apply_health_change_effect(effect)
		Knockback:
			print('kmocn', effect)
	
	#match effect.behavior:
		#Util.EffectBehavior.INSTANT:
			#apply_instant_effect(effect, source)
		#Util.EffectBehavior.OVERTIME:
			#add_damage_over_time_effect(effect)
		#Util.EffectBehavior.BUFF, Util.EffectBehavior.DEBUFF:
			#add_stat_modifier(effect)

func take_damage(damage: DamageEffect):
	var final_damage = damage.amount
	
	health.take_damage(final_damage)

func heal(healing: HealEffect):
	var final_heal = healing.amount
	
	health.heal(final_heal)

func handle_health_change(effect: HealthChange):
	match effect.get_script():
		HealEffect:
			heal(effect)
		DamageEffect:
			take_damage(effect)

func apply_health_change_effect(effect: HealthChange):
	if effect.duration > 0:
		add_health_change_overtime_effect(effect)
	else:
		handle_health_change(effect)
	
func add_health_change_overtime_effect(effect: HealthChange):
	active_overtime_effects.append({
		"effect": effect,
		"timer": 0.0,
		"elapsed": 0.0
	})

func add_damage_over_time_effect(effect: Effect):
	active_overtime_effects.append({
		"effect": effect,
		"timer": 0.0,
		"elapsed": 0.0
	})

func process_overtime_effect(delta: float):
	for overtime_effect in active_overtime_effects:
		var effect : HealthChange = overtime_effect.effect
		overtime_effect['elapsed'] += delta
		overtime_effect['timer'] += delta
		
		if overtime_effect['timer'] >= effect.tick_interval:
			overtime_effect['timer'] = 0.0
			handle_health_change(effect)
		
		if overtime_effect['elapsed'] >= effect.duration:
			#effect_ended.emit(effect.effect_type)
			active_overtime_effects.erase(overtime_effect)
			return

func apply_stat(data: StatModifierData):
	speed_multiplier *= data.speed_multiplier
	attack_multiplier *= data.attack_multiplier
	defense_multiplier *= data.defense_multiplier
	range_multiplier *= data.range_multiplier

func remove_stat(data: StatModifierData):
	speed_multiplier /= data.speed_multiplier
	attack_multiplier /= data.attack_multiplier
	defense_multiplier /= data.defense_multiplier
	range_multiplier /= data.range_multiplier

func add_stat_modifier(effect: Effect):
	if effect.stat_modifiers == null:
		return
	
	active_stat_modifiers[effect.effect_type] = {
		"modifier": effect.stat_modifiers,
		"remaining_time": effect.duration
	}
	
	apply_stat(effect.stat_modifiers)

func process_stat_modifiers(delta: float):
	for effect_type in active_stat_modifiers.keys():
		active_stat_modifiers[effect_type].remaining_time -= delta
		if active_stat_modifiers[effect_type].remaining_time <= 0:
			var modifier = active_stat_modifiers[effect_type].modifier
			remove_stat(modifier)
			effect_ended.emit(effect_type)
			active_stat_modifiers.erase(effect_type)
			break

func apply_knockback_from(origin: Vector2, strength: float):
	var direction = (global_position - origin).normalized()
	velocity_knockback = direction * strength

func process_knockback(delta: float):
	if velocity_knockback.length_squared() > 0.1:
		velocity_knockback = velocity_knockback.move_toward(Vector2.ZERO, knockback_friction * delta)

func apply_state(effect_type: Util.EffectType, duration: float):
	active_states[effect_type] = true
	state_timers[effect_type] = duration

func process_state_timers(delta: float):
	for effect_type in state_timers.keys():
		state_timers[effect_type] -= delta
		if state_timers[effect_type] <= 0:
			active_states[effect_type] = false
			state_timers.erase(effect_type)
			effect_ended.emit(effect_type)

func is_under(effect_type: Util.EffectType) -> bool:
	return active_states.get(effect_type, false)

func apply_instant_effect(effect: Effect, source: Node2D = null):
	if effect.damage_data:
		take_damage(effect.damage_data)
	
	if effect.healing_data:
		health.heal(effect.healing_data.amount)
	
	if effect.effect_type == Util.EffectType.KNOCKBACK:
		if source:
			apply_knockback_from(source.global_position, effect.knockback_strength)
	
	if effect.effect_type in [Util.EffectType.STUN, Util.EffectType.INVULNERABLE]:
		apply_state(effect.effect_type, effect.duration)
	
	if effect.stat_modifiers:
		add_stat_modifier(effect)
