extends Timer

@export var config : DamageOverTimeEffect
@onready var interval_timer: Timer = $IntervalTimer


func _ready() -> void:
	wait_time = config.duration
	interval_timer.wait_time = config.interval

func _on_interval_timer_timeout() -> void:
	get_parent().emit_signal('effect_hurt', config.damage)

func _on_timeout() -> void:
	queue_free()
