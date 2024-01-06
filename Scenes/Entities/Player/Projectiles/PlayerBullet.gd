extends Area2D
class_name PlayerBullet

const SPEED = 350
## Damage inflicted by the player bullet.
var damage: int = 20
## Direction of the player bullet.
var direction: Vector2 = Vector2.LEFT

## Called when the node is added to the scene.
func _ready() -> void:
	$BulletLifeDuration.start()

## Called every frame.
## Parameter delta: The time elapsed since the last frame.
func _process(delta) -> void:
	position += direction * SPEED * delta

## Called when the BulletLifeDuration timer times out.
func _on_bullet_life_duration_timeout() -> void:
	queue_free()

## Called when a body enters the area.
## Parameter body: The entered body.
func _on_body_entered(body: Node2D) -> void:
	if body is Area2D:
		return
	if body is EnviromentEntity:
		body.take_damage(damage, global_position)
	if body is EnemyBase:
		body.take_damage(damage, global_position)
	queue_free()
