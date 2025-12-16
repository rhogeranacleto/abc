extends Resource
class_name Util

enum AttackType {
	ALL
}

enum EffectType {
	NONE,
	STUN, # deixa ele parado? aumentar o cooldown
	SLOW, # deixa ele lento
	FREEZE, # deixa parado sem se mover
	KNOCKBACK, # empurra
	BLIND, # nao consegue ver os inimigos?
	BURN, # queima, e passa para os colegas
	POISON,
	ARMOR_REDUCTION,
	SPEED_BOOST,
	ATTACK_BOOST,
	DEVENSE_BOOST,
	REGENERATION,
	INVULNERABLE,
	COOLDOWN_REDUCTION
}

enum EffectBehavior {
	NONE,
	INSTANT,
	DAMAGE_OVERTIME,
	BUFF,
	DEBUFF,
	MOVEMENT
}

enum DamageCategory {
	NONE,
	PHYSICAL,
	ELEMENTAL,
	#MAGICAL
}

enum PhysicalType {
	NONE,
	SLASH
}

enum ElementalType {
	NONE,
	FIRE,
	ICE
}
