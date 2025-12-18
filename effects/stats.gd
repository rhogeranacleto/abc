extends Resource
class_name Stats

enum Types {
	MAX_HEALTH,
	ATTACK,
	DEFENSE,
	DAMAGE,
	RANGE_BONUS,
	SPEED,
	COOLDOWN
}

@export var max_health: Stat
@export var attack : Stat
@export var defense : Stat
@export var damage: Stat
@export var range_bonus : Stat
@export var speed : Stat
@export var cooldown : Stat
