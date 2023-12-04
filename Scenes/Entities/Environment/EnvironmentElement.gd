extends RigidBody2D
class_name EnviromentEntity


@export
var maxHealth: int = 40
var health: int = maxHealth


func take_damage(amount: int, _objectPosition: Vector2) -> void:
	health = clampi(health - amount, 0, maxHealth)
	if health <= 0:
		queue_free()
