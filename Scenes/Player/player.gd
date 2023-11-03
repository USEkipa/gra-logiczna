extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")


func _on_player_moving_bullet_shot(pos, direction):
	var bullet = bullet_scene.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	$Projectiles.add_child(bullet)
