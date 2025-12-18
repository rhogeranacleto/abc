extends Area2D

@export var effects_old : Array[EffectOld] = []
@export var effects : Array[Effect]

signal hitted

#func _ready() -> void:
	#if owner != null:
		#var owner_mask = owner.get('collision_mask')
		#
		#if owner_mask != null:
			#collision_mask = owner_mask

func area_entered(area: Area2D):
	print(area)
	
	area.emit_signal('effects_applied', effects_old)
	hitted.emit()

func _on_hit_box_body_entered(body: Node2D) -> void:
	print(body)
	if body.has_method('receive_hit'):
		body.receive_hit(effects, owner)
