extends Node2D

const PROJECTILE_PATH = preload("uid://dnn3pmet6y2tu")

@export_flags_2d_physics var collision_mask : int
@export var cooldown = 1.0
@export var PROJECTILE : PackedScene
@export var curve : Curve

#func _ready() -> void:
	#$RangeActivator.collision_mask = collision_mask

func create_projectile_path(target: Node2D):
	var path = PROJECTILE_PATH.instantiate()
	
	path.target = target.global_position
	path.global_position = global_position
	
	get_tree().root.add_child(path)

func get_arc(target: Vector2):
	var curve = Curve2D.new()
	# Calculate the distance from the target to the path
	var target_position = target - global_position #.limit_length(max_range)
	
	# This will make the first point displacement always the half of the distance of the start and end of the line
	# This influences the initial horizontal trajectory.
	var start_point_x_displacement = target_position.x / 2
	
	# The high of the arch is always the half of the distance
	# If the end point is above of start point, will double the distance (is a negative value)
	# if the end point is below the start point, will use -200 to get the same arch effect (otherwise the arc would be upside down)
	var start_point_y_displacement = min(2 * target_position.y,  -200)
	
	curve.add_point(Vector2.ZERO, Vector2.ZERO, Vector2(start_point_x_displacement, start_point_y_displacement))
	#curve.set_point_out(0, Vector2(start_point_x_displacement, start_point_y_displacement))
	curve.add_point(target_position)
		
	return curve
	#curve.set_point_position(1, target_position)

func throw_projectile(target: Node2D):
	var arc = get_arc(target.global_position)
	
	var path = Path2D.new()
	path.curve = arc
	
	var path_follow = PathFollow2D.new()
	path.add_child(path_follow)
	
	var projectile = PROJECTILE.instantiate()
	
	path_follow.add_child(projectile)
	
	get_tree().root.add_child(path)
	
	path_follow.rotates = false
	projectile.owner = path
	path.global_position = global_position
	
	var tween = create_tween()
	
	tween.tween_property(path_follow, 'progress_ratio', 1, 1.5)
	tween.finished.connect(func hit(): projectile.emit_signal('hit'))
	
	pass

func _on_range_activator_activate(sorted_targets: Array[Area2D]) -> void:
	#create_projectile_path(sorted_targets.get(0))
	throw_projectile(sorted_targets.get(0))
	$RangeActivator.start_cooldown(cooldown)
	
