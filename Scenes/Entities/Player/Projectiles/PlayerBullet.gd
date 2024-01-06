extends Area2D
class_name PlayerBullet

const SPEED = 350
var damage: int = 20
var direction: Vector2 = Vector2.LEFT


func _ready() -> void:
	$BulletLifeDuration.start()


func _process(delta) -> void:
	position += direction * SPEED * delta


func _on_bullet_life_duration_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Area2D:
		return
	if body is EnviromentEntity:
		body.take_damage(damage, global_position)
	if body is EnemyBase:
		body.take_damage(damage, global_position)
	queue_free()
