extends Node2D
class_name ContinuousBullet

@export var speed = 2000

@onready var hit_box: Area2D = $HitBox

const CONTINUOUS_BULLET = preload('uid://ds16y5s0r4nw8')

static func instanciate(effects : Array[Effect], collision_mask : int) -> ContinuousBullet:
	var projectile = CONTINUOUS_BULLET.instantiate()
	
	projectile.get_node('HitBox').effects = effects
	projectile.get_node('HitBox').collision_mask = collision_mask
	
	return projectile

func _process(delta: float) -> void:
	global_position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hit_box_hitted() -> void:
	
	queue_free()
