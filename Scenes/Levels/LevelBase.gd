extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")

@export var PlayerScene: Player


func _ready() -> void:
	Sounds.play_sound(Sounds.SoundType.START_GAME)
	Sounds.play_loop_sound(Sounds.SoundType.GAME, 1)
	PlayerScene.connect("bullet_shot", _on_player_bullet_shot)
	PlayerScene.connect("bullet_picked_up", _on_player_bullet_picked_up)
	PlayerScene.connect("coin_picked_up", _on_player_coin_picked_up)
	PlayerScene.connect("health_picked_up", _on_player_health_picked_up)
	PlayerScene.connect("damage_taken", _on_player_damage_taken)


func _on_player_bullet_shot(pos: Vector2, direction: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	$Projectiles.add_child(bullet)
	$HUD.remove_bullet()


func _on_player_bullet_picked_up(count: int) -> void:
	$HUD.set_bullet_count(count)


func _on_player_coin_picked_up(count: int) -> void:
	$HUD.add_score(count)


func _on_player_damage_taken(count: int) -> void:
	$HUD.add_health(count)


func _on_player_health_picked_up(count: int) -> void:
	$HUD.add_health(count)
