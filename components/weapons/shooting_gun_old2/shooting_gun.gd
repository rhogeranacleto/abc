extends RangeActivator

@export var BULLET: PackedScene
@onready var marker_2d: Marker2D = $Marker2D

func _on_activate(sorted_targets: Array[Area2D]) -> void:
	
	var angle_to = (sorted_targets.get(0).global_position - global_position).normalized().angle()
	
	var angle_diff = wrapf(angle_to - rotation, -PI, PI)
	
	var tween = create_tween()
	
	#print(angle_to)
		
	tween.tween_property(self, 'rotation', rotation + angle_diff, 0.05)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	
	await tween.finished
	
	#look_at(sorted_targets.get(0).global_position)
	
	var bullet = BULLET.instantiate()
	
	get_tree().root.add_child(bullet)
	
	bullet.global_position = marker_2d.global_position
	bullet.rotation = rotation
