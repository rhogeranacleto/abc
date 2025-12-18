extends Node
class_name StatsHandler

@export var stats : Stats

signal max_health_modified
signal attack_modified
signal defense_modified
signal damage_modified
signal range_bonus_modified
signal speed_modified
signal cooldown_modified

func _process(delta: float) -> void:
	for type in Stats.Types.keys():
		pass
	pass

func apply_modifiers(stats_modifiers: StatModifierData):
	for stat_name in stats_modifiers

func apply_modifier(type: Stats.Types, modifier: Modifier):
	var type_str = str(type).to_lower()
	var stat : Stat = stats.get(type_str)
	
	if not stat.modifiers.has(modifier):
		stat.modifiers.append(modifier)
		
		stat.modifier_changed.emit()
		emit_signal(str(type_str + "_modified"))
		
		if modifier.duration > 0.0:
			get_tree().create_timer(modifier.duration).timeout.connect(remove_modifier.bind(type, modifier))
	pass

func remove_modifier(type: Stats.Types, modifier: Modifier):
	var stat : Stat = stats.get(str(type).to_lower())
	
	stat.modifiers.erase(modifier)
	stat.modifier_changed.emit()
	
