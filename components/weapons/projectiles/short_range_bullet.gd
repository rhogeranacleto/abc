extends Node2D

@export_flags_2d_physics var collision_mask : int
@export var projectile_range : float = 500.0
@export var effects : Array[Effect]
@export var count = 7

@onready var hit_box : Area2D = $HitBox

var speed = 400
var angle = 9

func _ready() -> void:
	hit_box.collision_mask = collision_mask
	hit_box.effects = effects
	
	for i in range(count - 1):
		var duplicated_projectile = hit_box.duplicate()
		add_child(duplicated_projectile)
	
	var duration = projectile_range / speed
	
	for child in get_children():
		var index = child.get_index()
		
		var value = int((index + 1.0) / 2.0)
		var sign_of_operation = (index % 2) * 2 - 1
		var changer = sign_of_operation * value
		child.rotate(child.rotation + deg_to_rad(changer * angle))
		
		child.connect('hitted', child.queue_free)
		
		var tween = create_tween()
		
		tween.tween_property(child, 'position', child.transform.x * projectile_range, duration).as_relative()
		tween.parallel().tween_property(child, 'modulate', Color(0,0,0,0), duration / 2).set_delay(duration / 2)
		tween.parallel().tween_property(child.effects[0], 'damage', child.effects[0].damage / 10, duration)
		tween.connect('finished', child.queue_free)
	
