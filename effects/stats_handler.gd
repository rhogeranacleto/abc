extends Node
class_name StatsHandler

var stats: Stats

func _ready() -> void:
	if owner.stats:
		stats = owner.stats
		stats.buff_added.connect(create_remove_timer)

func create_remove_timer(stat_buff: StatBuff):
	if stat_buff.duration > 0.0:
		get_tree().create_timer(stat_buff.duration).timeout.connect(stats.remove_buff.bind(stat_buff))
