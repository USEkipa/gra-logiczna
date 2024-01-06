extends StateMachineState
class_name EnemyMovemementState

var animatedSprite: AnimatedSprite2D
var enemyBody: EnemyBase = null
var player: Player = null


func _init(_enemyBody: EnemyBase) -> void:
	enemyBody = _enemyBody
	player = _enemyBody.player
	animatedSprite = _enemyBody.animatedSprite


func update_delta(_delta: float) -> void:
	enemyBody.move_and_slide()

	if not enemyBody.is_on_floor():
		enemyBody.velocity.y += Globals.World.GRAVITY
	else:
		_move_toward_player()


func update_input(_event: InputEvent) -> void:
	pass


func _move_toward_player() -> void:
	if player == null:
		return
	if enemyBody.position.distance_to(player.position) > enemyBody.awarnessRange:
		enemyBody.velocity = Vector2()
		enemyBody.play_animation("idle")
		return

	var moveDirection := (player.position - enemyBody.position).normalized()
	enemyBody.velocity.x = moveDirection.x * enemyBody.movementSpeed
	if enemyBody.velocity.x > 0:
		animatedSprite.flip_h = false
		enemyBody.play_animation("run")
	elif enemyBody.velocity.x < 0:
		animatedSprite.flip_h = true
		enemyBody.play_animation("run")
