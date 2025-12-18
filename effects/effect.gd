@abstract extends Resource
class_name Effect

@export var id : String = "New effect"
#@export var effect_type : Util.EffectType = Util.EffectType.NONE


#@export var damage_data : HealthData
#@export var healing_data : HealthData
#@export var stat_modifiers : StatModifierData
#@export var outro : Dictionary[Stats.Types, Modifier]
