extends Node2D

@onready var gun_sprite: Sprite2D = $'../GunSprite'
@onready var weapon_range: WeaponRange = $'../WeaponRange'
@onready var marker: Marker2D = $'../GunSprite/Marker2D'
@onready var cooldown: Timer = $'../Cooldown'
@onready var weapon_controller: WeaponController = $'..'

func _process(_delta: float) -> void:
	var in_range = weapon_range.get_overlapping_bodies()
	
	if in_range.is_empty():
		return
	
	var nearest = in_range.reduce(Helpers.get_nearest_to_position.bind(global_position))
	
	gun_sprite.look_at(nearest.global_position)
	
	if cooldown.is_stopped():
		shoot()

func shoot():
	cooldown.start(weapon_controller.recalculate_coodown())
	
	var projectile = ContinuousBullet.instanciate(weapon_controller.effects, weapon_range.collision_mask)
	
	get_tree().root.add_child(projectile)
	
	projectile.global_rotation = gun_sprite.global_rotation
	projectile.global_position = marker.global_position
