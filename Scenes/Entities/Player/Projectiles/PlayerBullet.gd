extends Area2D
class_name PlayerBullet

const SPEED = 350
var damage: int = 20
var direction: Vector2 = Vector2.LEFT


func _ready():
	$BulletLifeDuration.start()


func _process(delta):
	position += direction * SPEED * delta


func _on_bullet_life_duration_timeout():
	queue_free()


func _on_body_entered(body) -> void:
	if body is Area2D:
		return
	if body is RigidBody2D:
		body.take_damage(10, global_position)
	queue_free()
