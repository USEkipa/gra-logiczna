extends Node2D


const bullet_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")


func _on_player_bullet_shot(pos, direction):
	var bullet = bullet_scene.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	$Projectiles.add_child(bullet)
	$HUD.remove_bullet()


func _on_player_bullet_picked_up(count):
	$HUD.set_bullet_count(count)


func _on_player_coin_picked_up(count):
	$HUD.add_score(count)


func _on_player_damage_taken(count):
	$HUD.add_health(count)


func _on_player_health_picked_up(count):
	$HUD.add_health(count)


func _on_test_object_body_entered(body):
	if "take_damage" in body:
		body.take_damage(10)
