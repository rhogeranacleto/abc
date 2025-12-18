@abstract extends Effect
class_name HealthChange

#@export var behavior : Util.EffectBehavior = Util.EffectBehavior.INSTANT
@export var amount : float
@export var duration : float = 0.0
@export var tick_interval : float = 1.0
