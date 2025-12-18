extends Node
class_name StatsHandler

@export var stats : Stats

signal max_health_modified
signal attack_modified
signal defense_modified
signal range_bonus_modified
signal speed_modified
signal cooldown_modified

func apply_buff(stat_buff: StatBuff):
	var type_str = Stats.Types.find_key(stat_buff.name).to_lower()
	
	var stat : Stat = stats.get(type_str)
	
	if not stat.modifiers.has(stat_buff):
		stat.modifiers.append(stat_buff)
		
		stat.modifier_changed.emit()
		emit_signal(str(type_str + "_modified"))
		
		if stat_buff.duration > 0.0:
			get_tree().create_timer(stat_buff.duration).timeout.connect(remove_buff.bind(stat_buff))
	pass

func remove_buff(stat_buff: StatBuff):
	var type_str = Stats.Types.find_key(stat_buff.name).to_lower()
	
	var stat : Stat = stats.get(type_str)
	
	stat.modifiers.erase(stat_buff)
	stat.modifier_changed.emit()

	
