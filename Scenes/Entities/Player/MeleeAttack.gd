extends Area2D

@export var MELEE_DAMAGE : int = 50

## Signal handler for the "body_entered" signal of the Area2D.
func _on_body_entered(body):
	if body is EnemyBase or body is EnviromentEntity:
		body.take_damage(MELEE_DAMAGE, global_position)
