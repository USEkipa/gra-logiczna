extends StateMachineState
class_name EnemyMovemementState

var enemyBody: EnemyBase = null
var player: Player = null

var movementSpeed: int = 50


func set_enemy(_enemyBody: EnemyBase) -> void:
	enemyBody = _enemyBody
	player = _enemyBody.player


func update_input(_event: InputEvent) -> void:
	pass


func update_delta(_delta: float) -> void:
	enemyBody.move_and_slide()

	if not enemyBody.is_on_floor():
		enemyBody.velocity.y += Globals.World.GRAVITY
	else:
		_move_toward_player()


func _move_toward_player() -> void:
	if player == null:
		return

	var moveDirection := (player.position - enemyBody.position).normalized()
	enemyBody.velocity.x = moveDirection.x * movementSpeed
