extends Path2D

@export var max_range = 400
@export var target = Vector2.ZERO


func _ready() -> void:
	var target_position = (target - global_position) #.limit_length(max_range)
		
	curve.set_point_out(0, Vector2(target_position.x / 2, min(2 * target_position.y,  -200)))
	
	curve.set_point_position(1, target_position)

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
