extends Label
class_name HitAmount

const HEAL_COLOR = Color(0.275, 1.0, 0.0)
const DAMAGE_COLOR = Color(0.905, 0.0, 0.0)

@onready var animation_player = $AnimationPlayer

const HIT_AMOUNT = preload('uid://dtjuj82gav4h0')

var animation_type : String

static func instanciate(amount: int) -> HitAmount:
	var instance : HitAmount = HIT_AMOUNT.instantiate()
	
	if amount > 0.0:
		instance.text = '+' + str(amount)
		instance.animation_type = 'heal'
	else:
		instance.text = str(amount)
		instance.animation_type = 'damage'
	
	return instance

func _ready() -> void:
	animation_player.play(animation_type)
	
	animation_player.animation_finished.connect(queue_free)
