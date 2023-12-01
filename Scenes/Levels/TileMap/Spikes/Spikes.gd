extends Area2D

const SPIKE_DAMAGE = 100


func _on_body_entered(body):
	if body is Entity:
		body.take_damage(SPIKE_DAMAGE)
