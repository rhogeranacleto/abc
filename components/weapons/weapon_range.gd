extends Area2D
class_name WeaponRange

func update_shape_range(range_distance: float):
	$CollisionShape2D.shape.radius = range_distance
