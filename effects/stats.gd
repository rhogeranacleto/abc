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

@export var max_health: Stat = Stat.new()
@export var attack: Stat = Stat.new()
@export var defense: Stat = Stat.new()
@export var range_bonus: Stat = Stat.new()
@export var speed: Stat = Stat.new()
@export var cooldown: Stat = Stat.new()
@export var dependencies: Array[Stats] = []

signal max_health_modified
signal attack_modified
signal defense_modified
signal range_bonus_modified
signal speed_modified
signal cooldown_modified

signal buff_added(stat_buff: StatBuff)
signal buff_removed(stat_buff: StatBuff)

func apply_buff(stat_buff: StatBuff):
	var type_str = Stats.Types.find_key(stat_buff.name).to_lower()
	
	var stat: Stat = get(type_str)
	
	if not stat.modifiers.has(stat_buff):
		stat.modifiers.append(stat_buff)
		
		#stat.modifier_changed.emit()
		emit_signal(str(type_str + "_modified"))
		buff_added.emit(stat_buff)

func remove_buff(stat_buff: StatBuff):
	var type_str = Stats.Types.find_key(stat_buff.name).to_lower()
	print('remove', stat_buff.name, stat_buff)
	var stat : Stat = get(type_str)
	
	stat.modifiers.erase(stat_buff)
	#stat.modifier_changed.emit()
	emit_signal(str(type_str + "_modified"))
	buff_removed.emit(stat_buff)
	

func get_final_value(type: Types) -> float:
	var stat_name = Types.find_key(type).to_lower()
	var stat: Stat = get(stat_name)
	
	#print(stat.modifiers)
	
	var adds = stat.aggregate_by_type(StatBuff.Type.ADD, 0.0)
	var multiply = stat.aggregate_by_type(StatBuff.Type.MULTIPLY, 1.0)
	
	for dependency in dependencies:
		var dependency_stat: Stat = dependency.get(stat_name)
		
		adds += dependency_stat.aggregate_by_type(StatBuff.Type.ADD, 0.0)
		multiply += dependency_stat.aggregate_by_type(StatBuff.Type.MULTIPLY, 0.0)
	
	print(stat.base_value, ' added ', adds, ' multipleied ', multiply, ' results ', (stat.base_value + adds) * multiply)
	return (stat.base_value + adds) * multiply
