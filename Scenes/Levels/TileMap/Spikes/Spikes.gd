extends Area2D

const SPIKE_DAMAGE = 100


## Signal handler called when a physics body enters the area of the spike.
func _on_body_entered(body):
	if body is Entity:
		body.take_damage(SPIKE_DAMAGE, global_position)
