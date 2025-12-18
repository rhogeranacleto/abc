extends Area2D

@export var cooldown = 1.0
@export var max_health = 100 :
	set(value):
		max_health = value
		
		if max_health < health:
			health = max_health
		
		if health_bar != null:
			health_bar.max_value = max_health
		
@export var health = 100 :
	set(value):
		health = min(value, max_health)
		if health_bar != null:
			health_bar.value = health

@export var health_bar : ProgressBar
@export var legs : Node2D

@onready var cooldown_timer: Timer = $Cooldown

const DAMAGE_OVERTIME_EFFECT = preload("uid://dto1t3clx6j88")
const DAMAGE_HIT_DISPLAY = preload("uid://bxe58yo6eqj7b")

signal hurt(amount: float)
signal effect_hurt(amount: float)
signal effects_applied(effects: Array[EffectOld])

func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = health
	
func take_damage(amount):
	health -= amount
	
	var damage_hit = DAMAGE_HIT_DISPLAY.instantiate()
	
	damage_hit.value = amount
	damage_hit.global_position = global_position
	get_tree().root.add_child(damage_hit)
	damage_hit.owner = owner
	
	if health < 0 and owner != null:
		owner.queue_free()

func _on_hurt(amount: float) -> void:
	if not cooldown_timer.is_stopped():
		return
	
	take_damage(amount)
	
	if cooldown > 0.0:
		cooldown_timer.start(cooldown)
	
func _on_effects_applied(effects: Array[EffectOld]) -> void:
	for effect in effects:
		match effect.get_script():
			DamageOverTimeEffect:
				var damage_overtime = DAMAGE_OVERTIME_EFFECT.instantiate()
				damage_overtime.config = effect
				add_child(damage_overtime)
			OneHitDamage:
				_on_hurt(effect.damage)
			SlowEffect:
				legs.emit_signal('slowed', effect.speed_modifier, effect.duration)
