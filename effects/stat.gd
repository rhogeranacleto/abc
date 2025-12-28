extends Resource
class_name Stat

#signal modifier_changed

@export var base_value : float
@export var modifiers : Array[StatBuff]

func calculate_final_value():
	var adds = aggregate_by_type(StatBuff.Type.ADD, 0.0)
	var multiply = aggregate_by_type(StatBuff.Type.MULTIPLY, 1.0)
	
	return (base_value + adds) * multiply

func aggregate_by_type(type: StatBuff.Type, base: float) -> float:
	return modifiers\
		.filter(func get_add(modifier): return modifier.type == type)\
		.reduce(func sum(total, modifier): return total + modifier.amount, base)
