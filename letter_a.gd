extends Node2D

@onready var gun: Node2D = $Gun
@onready var bt_player: BTPlayer = $BTPlayer

#@export var gun

func _process(delta: float) -> void:
	var target = bt_player.blackboard.get_var('nearest_target')
	
	if not target == null:
		# animated gun look at
		#var angle = get_angle_to(target.global_position)
		#gun.rotation = lerp_angle(gun.rotation, angle, 20.0 * delta)
		gun.look_at(target.global_position)

	pass
