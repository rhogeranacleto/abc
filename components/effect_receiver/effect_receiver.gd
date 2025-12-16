extends Node2D

# code taken from https://youtu.be/pNBWcw_xliA?si=zHStKFVgIX8YPSgg

signal effect_started(effect_type: Util.EffectType)
signal effect_ended(effect_type: Util.EffectType)
signal health_changed(current_health: float, max_health: float)
signal damaged(amount: float)
signal died

@export var max_health : int = 100
var current_health : int = 100

var velocity_knockback : Vector2 = Vector2.ZERO
var knockback_friction : float = 800.0

var active_damage_over_time: Array[Dictionary] = []
var active_stat_modifiers: Dictionary = {}

var speed_multiplier := 1.0
var attack_multiplier := 1.0
var defense_multiplier := 1.0

var active_states: Dictionary = {}
var state_timers: Dictionary = {}

func _physics_process(delta: float) -> void:
	process_damage_over_time(delta)
	process_stat_modifiers(delta)
	process_state_timers(delta)
	process_knockback(delta)

func apply_effect(effect: Effect, source: Node2D = null):
	print(effect.name)
	
	effect_started.emit(effect.effect_type)
	
	match effect.behavior:
		Util.EffectBehavior.INSTANT:
			apply_instant_effect(effect, source)
		Util.EffectBehavior.DAMAGE_OVERTIME:
			add_damage_over_time_effect(effect)
		Util.EffectBehavior.BUFF, Util.EffectBehavior.DEBUFF:
			add_stat_modifier(effect)

func take_damage(damage: DamageData):
	var final_damage = damage.amount
	current_health = clamp(current_health - final_damage, 0, max_health)
	
	damaged.emit(final_damage)
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		died.emit()

func add_damage_over_time_effect(effect: Effect):
	active_damage_over_time.append({
		"effect": effect,
		"timer": 0.0,
		"elapsed": 0.0
	})

func process_damage_over_time(delta: float):
	for dot in active_damage_over_time:
		var effect : Effect = dot.effect
		dot['elapsed'] += delta
		dot['timer'] += delta
		
		if dot['timer'] >= effect.tick_interval:
			dot['timer'] = 0.0
			if effect.damage:
				take_damage(effect.damage)
		
		if dot['elapsed'] >= effect.duration:
			effect_ended.emit(effect.effect_type)
			active_damage_over_time.erase(dot)
			return

func apply_stat(data: StatModifierData):
	speed_multiplier *= data.speed_multiplier
	attack_multiplier *= data.attack_multiplier
	defense_multiplier *= data.defense_multiplier

func remove_stat(data: StatModifierData):
	speed_multiplier /= data.speed_multiplier
	attack_multiplier /= data.attack_multiplier
	defense_multiplier /= data.defense_multiplier

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
	if effect.damage:
		take_damage(effect.damage)
	
	if effect.effect_type == Util.EffectType.KNOCKBACK:
		if source:
			apply_knockback_from(source.global_position, effect.knockback_strength)
	
	if effect.effect_type in [Util.EffectType.STUN]:
		apply_state(effect.effect_type, effect.duration)
	
	if effect.stat_modifiers:
		add_stat_modifier(effect)
