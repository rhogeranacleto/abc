extends Effect
class_name StatBuff

enum Type {
	ADD,
	MULTIPLY
}

@export var name : Stats.Types
@export var amount : float
@export var type : StatBuff.Type
@export var duration : float = 0.0
#@export var tick_interval : float = 1.0

var effect_name = 'stat_buff'
