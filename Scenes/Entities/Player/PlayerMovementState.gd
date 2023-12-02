extends StateMachineState
class_name PlayerMovementState

var player: Player = null
var gpuPlayerParticles: GPUParticles2D = null
var playerAnimations: AnimatedSprite2D = null
var bulletStartPosition: Node2D = null
var isStaggered: bool = false
var isDead: bool = false
var avaibleJumps: int
var lastDirection = Vector2.LEFT


func set_player(_player: Player) -> void:
	player = _player
	gpuPlayerParticles = _player.get_node("GPUParticles2D")
	playerAnimations = _player.get_node("Animations")
	bulletStartPosition = _player.get_node("BulletStartPositions")
	avaibleJumps = player.maxJumps


func change_components_direction(direction) -> void:
	if direction == Vector2.LEFT:
		gpuPlayerParticles.position = Vector2(
			-abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y)
		gpuPlayerParticles.process_material.direction = Vector3(-1, 0, 0)
		playerAnimations.flip_h = false
		for marker in bulletStartPosition.get_children():
			marker.position.x = -abs(marker.position.x)
		lastDirection = Vector2.LEFT
	elif direction == Vector2.RIGHT:
		gpuPlayerParticles.position = Vector2(
			abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y)
		gpuPlayerParticles.process_material.direction = Vector3(1, 0, 0)
		playerAnimations.flip_h = true
		for marker in bulletStartPosition.get_children():
			marker.position.x = abs(marker.position.x)
		lastDirection = Vector2.RIGHT


func get_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	return Vector2.ZERO


func jumpManager() -> void:
	if Input.is_action_just_pressed("up") and avaibleJumps > 0:
		Sounds.play_sound(Sounds.SoundType.JUMP)
		playerAnimations.play("jump")
		avaibleJumps -= 1
		player.velocity.y = player.jumpVelocity + abs(player.velocity.x) * 0.3
	elif not player.is_on_floor():
		player.simulate_gravity()
		if player.velocity.y >= 0:
			playerAnimations.play("fall")


func runManager(direction: Vector2) -> void:
	change_components_direction(direction)
	player.velocity.x = direction.x * player.speed
	if direction != Vector2.ZERO:
		if avaibleJumps == player.maxJumps:
			playerAnimations.play("run")
	else:
		if avaibleJumps == player.maxJumps:
			playerAnimations.play("idle")


func shootingManager() -> void:
	if (
		Input.is_action_pressed("shoot")
		and player.canShoot
		and player.bulletCount > 0
	):
		Sounds.play_sound(Sounds.SoundType.START_GAME) # zmienić to
		gpuPlayerParticles.set_emitting(true)
		player.canShoot = false
		player.get_node("BulletTimer").start()
		player.bullet_shot.emit(player.get_random_marker().global_position, lastDirection)
		player.add_bullets(-1)


func reset_jumps() -> void:
	if player.is_on_floor() and avaibleJumps < player.maxJumps:
		avaibleJumps = player.maxJumps


func update_input(event: InputEvent) -> void:
	if not isDead:
		if event.is_action_pressed("down") && player.is_on_floor():
			player.position.y += 3


func update_delta(_delta: float) -> void:
	if not isDead:
		var direction = get_direction()
		if not isStaggered:
			runManager(direction)
			jumpManager()
			shootingManager()
		if isStaggered:
			player.velocity.x = -lastDirection.x * player.staggerForce
		player.move_and_slide()
		reset_jumps()
