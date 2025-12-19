extends Resource
class_name Stats

enum Types {
	MAX_HEALTH,
	ATTACK,
	DEFENSE,
	RANGE_BONUS,
	SPEED,
	COOLDOWN
}

@export var max_health: Stat
@export var attack: Stat
@export var defense: Stat
@export var range_bonus: Stat
@export var speed: Stat
@export var cooldown: Stat
@export var dependencies: Array[Stats] = []

func get_final_value(type: Types) -> float:
	var stat_name = Types.find_key(type).to_lower()
	var stat: Stat = get(stat_name)
	
	var adds = stat.aggregate_by_type(StatBuff.Type.ADD, 0.0)
	var multiply = stat.aggregate_by_type(StatBuff.Type.MULTIPLY, 1.0)
	
	for dependency in dependencies:
		var dependency_stat: Stat = dependencies.get(stat_name)
		
		adds += dependency_stat.aggregate_by_type(StatBuff.Type.ADD, 0.0)
		multiply += dependency_stat.aggregate_by_type(StatBuff.Type.MULTIPLY, 1.0)
	
	return (stat.base_value + adds) * multiply
