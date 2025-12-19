extends ProgressBar

@export var health : Health

@onready var damage_bar : ProgressBar = $Damage

const HIT_AMOUNT = preload("uid://dtjuj82gav4h0")

func _ready() -> void:
	damage_bar.value = value
	damage_bar.max_value = max_value
	
	health.health_changed.connect(update)
	health.healed.connect(create_hit.bind(1))
	health.damaged.connect(create_hit.bind(-1))

func update(current_health: float, max_health: float):
	value = current_health
	max_value = max_health
	damage_bar.max_value = max_health
	
	var tween = create_tween()
	
	tween.tween_property(damage_bar, 'value', current_health, 0.3).set_delay(0.5)

func create_hit(amount: float, multiplier : int):
	var hit_amount = HitAmount.instanciate(int(amount * multiplier))
	
	add_child(hit_amount)
		
	hit_amount.position.y = -size.y
	hit_amount.position.x = size.x * value / max_value - hit_amount.size.x / 2
