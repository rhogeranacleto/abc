extends Resource
class_name Util

enum Team {
	player,
	enemy
}

#enum AttackType {
	#ALL
#}

enum EffectType {
	NONE,
	STUN, # deixa ele parado? aumentar o cooldown
	SLOW, # deixa ele lento
	FREEZE, # deixa parado sem se mover
	KNOCKBACK, # empurra
	#BLIND, # nao consegue ver os inimigos?
	BURN, # queima, e passa para os colegas
	POISON, # da dano com o tempo sozinho
	ARMOR_REDUCTION, # diminui a defesa
	SPEED_BOOST, # deixa mais rapido
	ATTACK_BOOST, # adiciona dano
	DEFENSE_BOOST, # aumenta a defesa
	REGENERATION, # cura
	INVULNERABLE, # desabilita tomar danos
	COOLDOWN_REDUCTION, # diminui o cooldown
	RANGE_BOOST # aumenta o range
}

enum EffectBehavior {
	#NONE,
	INSTANT, # imediatamente
	OVERTIME, # dano ao longo do tempo
	#BUFF,
	#DEBUFF,
	#MOVEMENT
}

enum DamageCategory {
	NONE,
	#PHYSICAL,
	ELEMENTAL,
	#MAGICAL
}

#enum PhysicalType {
	#NONE,
	#SLASH
#}

enum ElementalType {
	NONE,
	FIRE,
	ICE
}
