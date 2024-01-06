extends Area2D

const SPIKE_DAMAGE = 100

## Function: `_on_body_entered(body)`
- **Description**: Signal handler called when a physics body enters the area of the spike.
- **Parameters**:
  - `body`: The physics body that entered the spikes area.
- **Actions**:
  - Checks if the entering body is an instance of the `Entity` class.
  - If true, calls the `take_damage` function on the `Entity` with the specified damage (`SPIKE_DAMAGE`) and the global position of the spike.
func _on_body_entered(body):
	if body is Entity:
		body.take_damage(SPIKE_DAMAGE, global_position)
