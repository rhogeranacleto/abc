extends Node2D
class_name WeaponController

@export var stats: Stats
@export var effecs: Array[Effect]
@export var cooldown: Timer
@export var weapon_range: WeaponRange

var owner_stats: Stats

func _ready() -> void:
	if owner.stats:
		owner_stats = owner.stats
		stats.dependencies.append(owner_stats)
		owner_stats.range_bonus_modified.connect(recalculate_range)
		owner_stats.cooldown_modified.connect(update_cooldown)
		
		call_deferred('update_collision_mask')
	
	recalculate_range()
	
func recalculate_range():
	if weapon_range != null:
		var final_range = stats.get_final_value(Stats.Types.RANGE_BONUS)
		
		weapon_range.update_shape_range(final_range)

func update_cooldown():
	if cooldown != null:
		cooldown.wait_time = stats.get_final_value(Stats.Types.COOLDOWN)

func update_collision_mask():
	match owner.collision_layer:
			1:
				weapon_range.collision_mask = 2
			2:
				weapon_range.collision_mask = 1
