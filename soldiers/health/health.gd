extends ProgressBar

@onready var damage_bar : ProgressBar = $Damage

var prev_value : float

const HIT_AMOUNT = preload("uid://dtjuj82gav4h0")

func _ready() -> void:
	damage_bar.value = value
	damage_bar.max_value = max_value

func _on_changed() -> void:
	damage_bar.max_value = max_value

func _on_value_changed(new_value: float) -> void:
	var tween = create_tween()
	
	var difference = value - prev_value
	
	var hit_amount : Label = HIT_AMOUNT.instantiate()
	
	hit_amount.text = str(difference)
	
	add_child(hit_amount)
	
	hit_amount.position.y = -size.y
	hit_amount.position.x = size.x * value / max_value - hit_amount.size.x / 2
	tween.tween_property(damage_bar, 'value', new_value, 0.3).set_delay(0.5)
