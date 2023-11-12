extends StateMachineState
class_name PlayerMovementState

var playerBody: Player = null
var gpuPlayerParticles: GPUParticles2D = null
var playerAnimations: AnimatedSprite2D = null
var bulletStartPosition: Node2D = null

var avaible_jumps = Globals.PlayerStats.MAX_JUMPS
var last_dir = Vector2.LEFT


func set_player(_playerBody: Player) -> void:
	playerBody = _playerBody
	gpuPlayerParticles = _playerBody.get_node("GPUParticles2D")
	playerAnimations = _playerBody.get_node("Animations")
	bulletStartPosition = _playerBody.get_node("BulletStartPositions")


func change_components_direction(direction) -> void:
	if direction == Vector2.LEFT:
		gpuPlayerParticles.position = Vector2(
			-abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y
		)
		gpuPlayerParticles.process_material.direction = Vector3(-1, 0, 0)
		playerAnimations.flip_h = false
		for marker in bulletStartPosition.get_children():
			marker.position.x = -abs(marker.position.x)
	elif direction == Vector2.RIGHT:
		gpuPlayerParticles.position = Vector2(
			abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y
		)
		gpuPlayerParticles.process_material.direction = Vector3(1, 0, 0)
		playerAnimations.flip_h = true
		for marker in bulletStartPosition.get_children():
			marker.position.x = abs(marker.position.x)


func get_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	return Vector2.ZERO


func jump():
	if Input.is_action_just_pressed("up") and avaible_jumps > 0:
		Sounds.play_sound(Sounds.SoundType.JUMP)
		playerAnimations.play("jump")
		avaible_jumps -= 1
		playerBody.velocity.y = Globals.PlayerStats.JUMP_VELOCITY + abs(playerBody.velocity.x) * 0.3
	elif not playerBody.is_on_floor():
		playerBody.velocity.y += Globals.PlayerStats.GRAVITY
		if playerBody.velocity.y >= 0:
			playerAnimations.play("fall")


func reset_jumps():
	if playerBody.is_on_floor() and avaible_jumps < Globals.PlayerStats.MAX_JUMPS:
		avaible_jumps = Globals.PlayerStats.MAX_JUMPS


func update_input(event: InputEvent) -> void:
	if event.is_action_pressed("down") && playerBody.is_on_floor():
		playerBody.position.y += 3


func update_delta(_delta: float) -> void:
	var direction = get_direction()
	change_components_direction(direction)

	playerBody.velocity.x = direction.x * Globals.PlayerStats.SPEED

	if direction != Vector2.ZERO:
		last_dir = direction
		if avaible_jumps == Globals.PlayerStats.MAX_JUMPS:
			playerAnimations.play("run")
	else:
		if avaible_jumps == Globals.PlayerStats.MAX_JUMPS:
			playerAnimations.play("idle")
	jump()
	playerBody.move_and_slide()
	reset_jumps()
	if (
		Input.is_action_pressed("shoot")
		and playerBody.can_shoot
		and Globals.PlayerStats.bulletCount > 0
	):
		Sounds.play_sound(Sounds.SoundType.START_GAME) # zmienić to
		gpuPlayerParticles.set_emitting(true)
		playerBody.can_shoot = false
		playerBody.get_node("BulletTimer").start()
		playerBody.bullet_shot.emit(playerBody.get_random_marker().global_position, last_dir)
