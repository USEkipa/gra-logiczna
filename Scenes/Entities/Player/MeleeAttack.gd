extends Area2D

@export var MELEE_DAMAGE : int = 50

func _on_body_entered(body):
	if body is EnemyBase or body is EnviromentEntity:
		body.take_damage(MELEE_DAMAGE, global_position)
		print_debug(body.name + " took " + str(MELEE_DAMAGE))
