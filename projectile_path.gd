extends Path2D

@export var max_range = 400
@export var target = Vector2.ZERO
@onready var bomb: Node2D = $PathFollow2D/Bomb


func _ready() -> void:
	# Calculate the distance from the target to the path
	var target_position = target - global_position #.limit_length(max_range)
	
	# This will make the first point displacement always the half of the distance of the start and end of the line
	# This influences the initial horizontal trajectory.
	var start_point_x_displacement = target_position.x / 2
	
	# The high of the arch is always the half of the distance
	# If the end point is above of start point, will double the distance (is a negative value)
	# if the end point is below the start point, will use -200 to get the same arch effect (otherwise the arc would be upside down)
	var start_point_y_displacement = min(2 * target_position.y,  -200)
	
	curve.set_point_out(0, Vector2(start_point_x_displacement, start_point_y_displacement))
	
	curve.set_point_position(1, target_position)

func hit_ground():
	bomb.emit_signal('hit')

func x_unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_pos = (get_global_mouse_position() - position).limit_length(max_range)
	
	#curve.set_point_position(0, Vector2(0, 0))
		var first_x_tilt = mouse_pos.x / 2
	
		curve.set_point_out(1, Vector2(mouse_pos.x / 10, -100))
		
		print(first_x_tilt, mouse_pos)
		
		curve.set_point_position(1, mouse_pos)
		
		

func x_process(delta: float) -> void:
	var mouse_pos = (get_global_mouse_position() - position).limit_length(max_range)
	
	#curve.set_point_position(0, Vector2(0, 0))
	var first_x_tilt = mouse_pos.x / 2

	curve.set_point_out(1, Vector2(mouse_pos.x / 10, -100))
	
	print(first_x_tilt, mouse_pos)
	
	curve.set_point_position(1, mouse_pos)
