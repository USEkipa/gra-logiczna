extends Area2D

@export var MELEE_DAMAGE : int = 50

## Function: `_on_body_entered(body)`
##- **Description**: Signal handler for the "body_entered" signal of the Area2D.
##- **Parameters**:
##  - `body`: The object that entered the area.
##- **Actions**:
##  - Checks if the entering body is an instance of either `EnemyBase` or `EnviromentEntity`.
##  - Calls the `take_damage` method on the entering body, passing `MELEE_DAMAGE` and the global position.
func _on_body_entered(body):
	if body is EnemyBase or body is EnviromentEntity:
		body.take_damage(MELEE_DAMAGE, global_position)
